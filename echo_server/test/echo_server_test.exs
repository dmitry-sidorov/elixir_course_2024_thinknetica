defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  test "reply to :ping message" do
    {:ok, pid} = EchoServer.start_link()
    assert EchoServer.echo(pid, :ping) == {:pong, :nonode@nohost}
  end

  test "throw error" do
    {:ok, pid} = EchoServer.start_link()

    assert_raise RuntimeError, "Only :ping message is allowed!", fn ->
      EchoServer.echo(pid, :some) == {:pong, :nonode@nohost}
    end

    assert_raise RuntimeError, "Only :ping message is allowed!", fn ->
      EchoServer.echo(pid, %{}) == {:pong, :nonode@nohost}
    end

    assert_raise RuntimeError, "Only :ping message is allowed!", fn ->
      EchoServer.echo(pid, "ping") == {:pong, :nonode@nohost}
    end
  end
end
