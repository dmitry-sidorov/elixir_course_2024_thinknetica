defmodule EchoServer do
  use GenServer

  @moduledoc """
  Documentation for `EchoServer`.
  """

  @doc """
  Ping-pong.

  ## Examples
      iex> {:ok, pid} = EchoServer.start_link()
      iex> EchoServer.echo(pid, :ping)
      {:pong, :nonode@nohost}

  """

  # Client

  def start_link(default \\ %{}) do
    GenServer.start_link(__MODULE__, default)
  end

  def echo(pid, :ping) do
    GenServer.call(pid, :ping)
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:ping, {pid, _ref}, state) do
    send(pid, {:pong, node()})
    {:reply, {:pong, node()}, state}
  end
end
