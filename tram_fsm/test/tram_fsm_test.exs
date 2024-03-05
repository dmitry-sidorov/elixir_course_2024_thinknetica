defmodule TramFsmTest do
  use ExUnit.Case
  doctest TramFsm

  test "greets the world" do
    assert TramFsm.hello() == :world
  end
end
