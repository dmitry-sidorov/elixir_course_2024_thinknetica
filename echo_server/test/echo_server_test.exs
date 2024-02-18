defmodule EchoServerTest do
  use ExUnit.Case
  doctest EchoServer

  test "greets the world" do
    assert EchoServer.hello() == :world
  end
end
