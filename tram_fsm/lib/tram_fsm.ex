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

  @type transition() :: %Transition{name: atom(), from: atom(), to: atom()}
  @type tram_state() :: %{required(:tram_state) => atom()}
  @type transition_info() :: %{
          current_state: atom(),
          available_transitions: list(transition())
        }
  @type transition_application_success() :: {:reply, {:ok, tram_state()}, tram_state()}
  @type transition_application_error() ::
          {:ok, tram_state()} | {:error, String.t(), {:info, transition_info()}}
  @type info() :: {:reply, {:info, transition_info()}, tram_state()}

  @moduledoc """
  Documentation for `TramFsm`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> {:ok, pid} = TramFsm.start_link(%{tram_state: :moving})
      iex> TramFsm.info(pid)
      {:info, %{current_state: :moving, available_transitions: [:move, :stop, :block, :traffic_light, :bang, :repair]}}
      iex> TramFsm.transition(pid, :move)
      {:ok, %{tram_state: :in_depot}}
  """
  @spec start_link(tram_state()) :: {:ok, pid()} | {:error, String.t()}
  def start_link(default \\ %{tram_state: :in_depot}) do
    GenServer.start_link(__MODULE__, default)
  end

  @impl true
  @spec init(tram_state()) :: {:ok, tram_state()}
  def init(args) do
    {:ok, args}
  end

  @spec info(pid()) :: info()
  def info(pid) do
    GenServer.call(pid, :info)
  end

  @doc """
  Returns all transitions in a list
  """
  @spec transition_scheme :: list(transition())
  def transition_scheme do
    @transition_scheme
  end

  @doc """
  Returns possible transitions for current tram state
  """
  @spec get_available_transitions(tram_state()) :: list(transition())
  defp get_available_transitions(%{tram_state: current_state}) do
    @transition_scheme
    |> Enum.filter(fn
      %Transition{from: ^current_state} -> true
      _ -> false
    end)
    |> Enum.map(fn %Transition{name: name} -> name end)
  end

  @doc """
  Aggregates info for current tram state
  """
  @spec get_info(tram_state()) :: transition_info()
  defp(get_info(state)) do
    %{
      current_state: state.tram_state,
      available_transitions: get_available_transitions(state)
    }
  end

  @doc """
  Apply transition for selected process.
  """
  @spec transition(pid(), atom()) :: {:ok, String.t()} | {:error, String.t()}
  def transition(pid, transition_name) do
    transitions = @transition_scheme |> Enum.map(fn %Transition{name: name} -> name end)

    case transition_name in transitions do
      true -> GenServer.call(pid, {:transition, transition_name})
      false -> {:error, "transition #{transition_name} doesn't exist", GenServer.call(pid, :info)}
    end
  end

  @impl true
  @spec handle_call(:info, any(), tram_state()) :: info()
  def handle_call(:info, _, state) do
    {:reply, {:info, get_info(state)}, state}
  end

  @impl true
  @spec handle_call({:transition, atom()}, any(), tram_state()) ::
          transition_application_success() | transition_application_error()
  def handle_call({:transition, transition_name}, _, %{tram_state: tram_state} = old_state) do
    transition =
      @transition_scheme
      |> Enum.filter(fn
        %Transition{name: ^transition_name} -> true
        _ -> false
      end)
      |> Enum.find(fn
        %Transition{from: ^tram_state} -> true
        _ -> false
      end)

    apply_transition(transition, transition_name, old_state)
  end

  @doc """
  Send error for invalid transition application.
  """
  @spec apply_transition(transition() | nil, atom(), tram_state()) ::
          transition_application_error()
  defp apply_transition(nil, transition_name, state) do
    {:reply, {:error, "transition #{transition_name} is unapplicable", {:info, get_info(state)}},
     state}
  end

  @doc """
  Apply valid transition.
  """
  @spec apply_transition(transition() | nil, atom(), tram_state()) ::
          transition_application_success()
  defp apply_transition(%Transition{to: to}, _transition_name, _state) do
    new_state = %{tram_state: to}
    {:reply, {:ok, new_state}, new_state}
  end
end
