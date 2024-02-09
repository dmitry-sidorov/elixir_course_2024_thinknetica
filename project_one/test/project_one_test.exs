defmodule ProjectOneTest do
  use ExUnit.Case
  doctest ProjectOne

  test "calculates chmod" do
    assert ProjectOne.calculate_chmod(%{user: "rwx", group: "r-x", other: "r-x"}) == "755"
    assert ProjectOne.calculate_chmod(%{user: "rwx", group: "r--", other: "r--"}) == "744"
    assert ProjectOne.calculate_chmod(%{user: "r-x", group: "r-x", other: "r-x"}) == "555"
  end

  test "calculates chmod with missing key" do
    assert ProjectOne.calculate_chmod(%{user: "r-x", group: "rwx"}) == "570"
    assert ProjectOne.calculate_chmod(%{group: "rwx"}) == "070"
    assert ProjectOne.calculate_chmod(%{other: "rwx"}) == "007"
  end

  test "calculates chmod for empty map" do
    assert ProjectOne.calculate_chmod(%{}) == "000"
  end

  test "raises exception for wrong argument" do
    assert_raise BadMapError, fn ->
      ProjectOne.calculate_chmod("not map value")
    end
  end
end
