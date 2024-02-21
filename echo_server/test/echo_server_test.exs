defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  @error_message "no function clause matching in EchoServer.echo/2"

  test "reply to :ping message" do
    {:ok, pid} = EchoServer.start_link()
    assert EchoServer.echo(pid, :ping) == {:pong, :nonode@nohost}
    assert_receive {:pong, :nonode@nohost}
  end

  test "throw error for wrong arguments" do
    {:ok, pid} = EchoServer.start_link()

    for wrong_message <- [:some, %{}, "ping", ~c"ping", [], {:ping, "message"}] do
      assert_raise FunctionClauseError, @error_message, fn ->
        EchoServer.echo(pid, wrong_message)
      end
    end
  end
end
