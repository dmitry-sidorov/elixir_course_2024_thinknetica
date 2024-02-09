defmodule ProjectOneTest do
  use ExUnit.Case
  doctest ProjectOne

  test "greets the world" do
    assert ProjectOne.hello() == :world
  end
end
