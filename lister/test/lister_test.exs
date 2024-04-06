defmodule ListerTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest Lister

  property "should implement Listable protocol for String" do
    check all(test_string <- string(:alphanumeric)) do
      assert Lister.show(test_string) == String.to_charlist(test_string)
    end
  end

  property "should implement Listable protocol for List" do
    check all(test_list <- list_of({integer(), float()})) do
      assert Lister.show(test_list) == test_list
    end
  end

  property "should implement Listable protocol for Integer" do
    check all(test_int <- integer()) do
      assert Lister.show(test_int) == [test_int]
    end
  end

  property "should implement Listable protocol for Float" do
    check all(test_float <- float()) do
      assert Lister.show(test_float) == [test_float]
    end
  end

  property "should implement Listable protocol for Map" do
    check all(
            test_map <-
              map_of(
                string(:alphanumeric),
                string(:alphanumeric)
              )
          ) do
      assert Lister.show(test_map) == Map.to_list(test_map)
    end
  end

  property "should implement Listable protocol for Tuple" do
    check all(
            test_tuple <-
              tuple({string(:alphanumeric), integer()})
          ) do
      assert Lister.show(test_tuple) == Tuple.to_list(test_tuple)
    end
  end

  property "should implement Listable protocol for Atom" do
    check all(test_atom <- atom(:alphanumeric)) do
      assert Lister.show(test_atom) == [test_atom]
    end
  end

  defmodule TestStruct do
    defstruct [:name, :some]
  end

  defp generate_struct do
    gen all(name <- StreamData.string(:alphanumeric), some <- StreamData.string(:alphanumeric)) do
      %TestStruct{name: name, some: some}
    end
  end

  property "should work for custom Struct" do
    check all(test_struct <- generate_struct()) do
      assert Lister.show(test_struct) == Map.to_list(test_struct)
    end
  end
end
