defmodule TramFsm do
  use GenServer

  # Depot ---> |start the route| Move_to_station
  # Move_to_station ---> |finish the route| Depot
  # Move_to_station ---> |arrive to station| Stop_on_station
  # Stop_on_station ---> |moving to next station| Move_to_station
  # Stop_on_station ---> |open the doors| Doors_opened
  # Doors_opened ---> |close the doors|Stop_on_station
  # Doors_opened ---> |start onboarding passengers| Onboarding_passengers
  # Onboarding_passengers ---> |stop onboarding passengers| Doors_opened
  # Move_to_station ---> |railway_blocked| Stop_by_railway_block
  # Stop_by_railway_block ---> |continue the route| Move_to_station
  # Move_to_station ---> |traffic light red| Stop_by_traffic_light
  # Stop_by_traffic_light ---> |traffic light green| Move_to_station
  # Move_to_station ---> |unexpected accident happened| Stop_by_accident
  # Stop_by_accident ---> |open the doors| Emergency_doors_opening
  # Emergency_doors_opening --->|start rescue passengers| Rescue_passengers
  # Rescue_passengers ---> |stop rescue passengers| Emergency_doors_opening
  # Emergency_doors_opening ---> |close the doors| Stop_by_accident
  # Stop_by_accident ---> |move to service station| Service
  # Service ---> |back to depot| Depot

  @transition_map %{
    start_the_route: %{from: :depot, to: :move_to_station},
    finish_the_route: %{from: :move_to_station, to: :depot},
  }

  @moduledoc """
  Documentation for `TramFsm`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TramFsm.hello()
      :world

  """
  def start_link(default \\ %{tram_state: :depot}) do
    GenServer.start_link(__MODULE__, default)
  end

  def info(pid) do
    GenServer.call(pid, :info)
  end

  @impl true
  def handle_call(:info, {pid, _ref}, state) do
    IO.inspect(state)

    {:reply, {:info, state}, state}
  end

  def transition(pid, :start_the_route) do
    GenServer.call(pid, :start_the_route)
  end

  @impl true
  def handle_call(:start_the_route, {pid, _ref}, %{tram_state: :depot} = state) do
    new_state = %{tram_state: :move_to_station}
    {:reply, {:ok, new_state}, new_state}
  end

  @impl true
  def handle_call(:start_the_route, {pid, _ref}, state) do
    {:reply, {:error, :not_allowed_transition}, state}
  end

  def transition(pid, :start_the_route) do
    GenServer.call(pid, :start_the_route)
  end

  @impl true
  def handle_call(:start_the_route, {pid, _ref}, %{tram_state: :depot} = state) do
    new_state = %{tram_state: :move_to_station}
    {:reply, {:ok, new_state}, new_state}
  end

  @impl true
  def handle_call(:start_the_route, {pid, _ref}, state) do
    {:reply, {:error, :not_allowed_transition}, state}
  end
end
