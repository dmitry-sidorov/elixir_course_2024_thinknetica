defmodule ListerTest do
  use ExUnit.Case
  doctest Lister

  test "greets the world" do
    assert Lister.hello() == :world
  end
end
