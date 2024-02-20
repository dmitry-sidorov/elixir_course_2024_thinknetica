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

  def echo(pid, message) do
    case message do
      :ping -> GenServer.call(pid, message)
      _ -> raise "Only :ping message is allowed!"
    end
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end
end
