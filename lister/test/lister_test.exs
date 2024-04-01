defmodule ListerTest do
  use ExUnit.Case
  doctest Lister

  @test_count 100

  describe "should implement Listable protocol for String" do
    test_cases =
      StreamData.string(:alphanumeric)
      |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_string = Enum.at(test_cases, test_count)

        unless is_nil(test_string) do
          assert Lister.show(test_string) == String.to_charlist(test_string)
        end
      end
    end
  end

  describe "should implement Listable protocol for List" do
    test_cases =
      StreamData.list_of({StreamData.integer(), StreamData.float()}) |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_list = Enum.at(test_cases, test_count)

        unless is_nil(test_list) do
          assert Lister.show(test_list) == test_list
        end
      end
    end
  end

  describe "should implement Listable protocol for Integer" do
    test_cases =
      StreamData.integer() |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_int = Enum.at(test_cases, test_count)
        assert Lister.show(test_int) == [test_int]
      end
    end
  end

  describe "should implement Listable protocol for Float" do
    test_cases =
      StreamData.float() |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_float = Enum.at(test_cases, test_count)
        assert Lister.show(test_float) == [test_float]
      end
    end
  end

  describe "should implement Listable protocol for Map" do
    test_cases =
      StreamData.map_of(StreamData.string(:alphanumeric), StreamData.string(:alphanumeric))
      |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_map = Enum.at(test_cases, test_count)

        unless is_nil(test_map) do
          assert Lister.show(test_map) == Map.to_list(test_map)
        end
      end
    end
  end

  describe "should implement Listable protocol for Tuple" do
    test_cases =
      StreamData.tuple({StreamData.string(:alphanumeric), StreamData.integer()})
      |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_tuple = Enum.at(test_cases, test_count)

        unless is_nil(test_tuple) do
          assert Lister.show(test_tuple) == Tuple.to_list(test_tuple)
        end
      end
    end
  end

  describe "should implement Listable protocol for Atom" do
    test_cases =
      StreamData.atom(:alphanumeric)
      |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_atom = Enum.at(test_cases, test_count)

        assert Lister.show(test_atom) == [test_atom]
      end
    end
  end
end
