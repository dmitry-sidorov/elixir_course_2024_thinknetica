defmodule ListerTest do
  use ExUnit.Case

  @test_count 100

  describe "should implement Listable protocol for string" do
    test_cases =
      StreamData.string(?a..?9) |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      @tag :skip
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_string = Enum.at(test_cases, test_count)
        assert Lister.show(test_string) == String.to_charlist(test_string)
      end
    end
  end

  describe "should implement Listable protocol for integer" do
    test_cases =
      StreamData.integer() |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_int = Enum.at(test_cases, test_count)
        assert Lister.show(test_int) == [test_int]
      end
    end
  end

  describe "should implement Listable protocol for float" do
    test_cases =
      StreamData.float() |> Enum.take(@test_count)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_float = Enum.at(test_cases, test_count)
        assert Lister.show(test_float) == [test_float]
      end
    end
  end

  describe "should implement Listable protocol for list" do
    test_cases =
      StreamData.list_of({StreamData.integer(), StreamData.float()}) |> Enum.take(@test_count)

    dbg(test_cases)

    for test_count <- 1..@test_count do
      @tag test_count: test_count
      @tag test_cases: test_cases
      test "for #{test_count} test case", %{test_count: test_count, test_cases: test_cases} do
        test_list = Enum.at(test_cases, test_count)
        assert Lister.show(test_list) == test_list
      end
    end
  end
end
