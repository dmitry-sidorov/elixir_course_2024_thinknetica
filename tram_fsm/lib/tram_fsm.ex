defmodule TramFsm do
  use GenServer

  @transition_scheme %{
    "start_the_route" => %{from: :depot, to: :move_to_station},
    "finish_the_route" => %{from: :move_to_station, to: :depot},
    "arrive_to_station" => %{from: :move_to_station, to: :stop_on_station},
    "moving_to_next_station" => %{from: :stop_on_station, to: :move_to_station},
    "open_the_doors" => %{from: :stop_on_station, to: :doors_opened},
    "close_the_doors" => %{from: :doors_opened, to: :stop_on_station},
    "start_onboarding_passengers" => %{from: :doors_opened, to: :onboarding_passengers},
    "stop_onboarding_passengers" => %{from: :onboarding_passengers, to: :doors_opened},
    "railway_blocked" => %{from: :move_to_station, to: :stop_by_railway_block},
    "continue_the_route" => %{from: :stop_by_railway_block, to: :move_to_station},
    "traffic_light_red" => %{from: :move_to_station, to: :stop_by_traffic_light},
    "traffic_light_green" => %{from: :stop_by_traffic_light, to: :move_to_station},
    "unexpected_accident_happened" => %{from: :move_to_station, to: :stop_by_accident},
    "open_the_doors_emergency" => %{
      from: :stop_by_accident,
      to: :emergency_doors_opening
    },
    "start_rescue_passengers" => %{
      from: :emergency_doors_opening,
      to: :rescue_passengers
    },
    "stop_rescue_passengers" => %{
      from: :rescue_passengers,
      to: :emergency_doors_opening
    },
    "close_the_doors_emergency" => %{
      from: :emergency_doors_opening,
      to: :stop_by_accident
    },
    "move_to_service_station" => %{from: :stop_by_accident, to: :service},
    "back_to_depot" => %{from: :service, to: :depot}
  }

  @moduledoc """
  Documentation for `TramFsm`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> {:ok, pid} = TramFsm.start_link()
      iex> TramFsm.info(pid)
      {:info, %{current_state: :depot, available_transitions: ["start_the_route"]}}
      iex> TramFsm.transition(pid, "start_the_route")
      {:ok, %{tram_state: :move_to_station}}
  """
  def start_link(default \\ %{tram_state: :depot}) do
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

  defp get_available_transitions(%{tram_state: current_state}) do
    @transition_scheme
    |> Map.to_list()
    |> Enum.filter(fn 
      {_transition, %{from: ^current_state}} -> true
      _ -> false
     end)
    |> Enum.map(fn {transition, _} -> transition end)
  end

  defp get_info(state) do
    %{
      current_state: state.tram_state,
      available_transitions: get_available_transitions(state)
    }
  end

  def transition(pid, transition) do
    case Map.fetch(@transition_scheme, transition) do
      {:ok, transition_data} ->
        GenServer.call(pid, {:transition, transition_data})

      :error ->
        {:info, info} = GenServer.call(pid, :info)
        {:error, "transition doesn't exist", info}
    end
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
