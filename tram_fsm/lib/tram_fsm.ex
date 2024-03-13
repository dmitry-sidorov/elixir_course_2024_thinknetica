defmodule TramFsm do
  use GenServer

  @transition_scheme [
    %Transition{name: :move, from: :in_depot, to: :moving},
    %Transition{name: :move, from: :moving, to: :in_depot},
    %Transition{name: :stop, from: :moving, to: :on_station},
    %Transition{name: :move, from: :on_station, to: :moving},
    %Transition{name: :doors, from: :on_station, to: :onboarding_passengers},
    %Transition{name: :doors, from: :onboarding_passengers, to: :on_station},
    %Transition{name: :block, from: :moving, to: :blocked},
    %Transition{name: :block, from: :blocked, to: :moving},
    %Transition{name: :traffic_light, from: :moving, to: :on_red_light_stop},
    %Transition{name: :traffic_light, from: :on_red_light_stop, to: :moving},
    %Transition{name: :bang, from: :moving, to: :on_accident},
    %Transition{name: :doors, from: :on_accident, to: :rescue_passengers},
    %Transition{name: :doors, from: :rescue_passengers, to: :on_accident},
    %Transition{name: :move, from: :on_accident, to: :moving},
    %Transition{name: :repair, from: :moving, to: :on_service},
    %Transition{name: :move, from: :on_service, to: :in_depot}
  ]

  # @transition_scheme %{
  #   "move" => [
  #     %{from: :in_depot, to: :moving},
  #     %{from: :moving, to: :in_depot},
  #     %{from: :on_station, to: :moving},
  #     %{from: :on_accident, to: :moving},
  #     %{from: :on_service, to: :in_depot}
  #   ],
  #   "stop" => [
  #     %{from: :moving, to: :on_station}
  #   ],
  #   "doors" => [
  #     %{from: :on_station, to: :onboarding_passengers},
  #     %{from: :onboarding_passengers, to: :on_station},
  #     %{from: :on_accident, to: :rescue_passengers},
  #     %{from: :rescue_passengers, to: :on_accident}
  #   ],
  #   "block" => [
  #     %{from: :moving, to: :blocked},
  #     %{from: :blocked, to: :moving}
  #   ],
  #   "traffic_light" => [
  #     %{from: :moving, to: :on_red_light_stop},
  #     %{from: :on_red_light_stop, to: :moving}
  #   ],
  #   "bang" => [
  #     %{from: :moving, to: :on_accident}
  #   ],
  #   "repair" => [
  #     %{from: :moving, to: :on_service}
  #   ]
  # }

  @moduledoc """
  Documentation for `TramFsm`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> {:ok, pid} = TramFsm.start_link()
      iex> TramFsm.info(pid)
      {:info, %{current_state: :in_depot, available_transitions: ["start_the_route"]}}
      iex> TramFsm.transition(pid, "move")
      {:ok, %{tram_state: :move_to_station}}
  """
  def start_link(default \\ %{tram_state: :in_depot}) do
    GenServer.start_link(__MODULE__, default)
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  def info(pid) do
    GenServer.call(pid, :info)
  end

  def transition_scheme do
    @transition_scheme
  end

  @spec get_available_transitions(%{tram_state: atom()}) :: [atom()]
  defp get_available_transitions(%{tram_state: current_state}) do
    @transition_scheme
    |> IO.inspect()
    |> Enum.filter(fn
      %Transition{from: ^current_state} -> true
      _ -> false
    end)
    |> IO.inspect()
    |> Enum.map(fn %Transition{name: name} -> name end)
  end

  defp get_info(state) do
    %{
      current_state: state.tram_state,
      available_transitions: get_available_transitions(state)
    }
  end

  defp apply_transition(pid, [], transition_name) do
    {:info, info} = GenServer.call(pid, :info)
    {:error, "transition #{transition_name} doesn't exist", info}
  end

  defp apply_transition(pid, possible_transitions, transition_name) do
    possible_transitions |> Enum.find(%{name: transition_name})
  end

  def transition(pid, transition_name) do
    possible_transitions =
      Enum.filter(@transition_scheme, fn %Transition{name: name} ->
        name == transition_name
      end)

    apply_transition(pid, possible_transitions, transition_name)

    # case length(possible_transitions) do
    #   {:ok, transition_data} ->
    #     GenServer.call(pid, {:transition, transition_data})

    #   :error ->
    #     {:info, info} = GenServer.call(pid, :info)
    #     {:error, "transition doesn't exist", info}
    # end
  end

  @impl true
  def handle_call(:info, _, state) do
    {:reply, {:info, get_info(state)}, state}
  end

  @impl true
  def handle_call({:transition, %{from: from, to: to}}, _, %{tram_state: from} = state) do
    new_state = %{tram_state: to}
    {:reply, {:ok, new_state}, new_state}
  end

  @impl true
  def handle_call({:transition, %{to: to}}, _, %{tram_state: to} = state) do
    {:reply, {:error, "tram is already in required state #{state.tram_state}"}, state}
  end
end
