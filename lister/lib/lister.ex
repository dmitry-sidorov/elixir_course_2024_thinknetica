defmodule Lister do
  @moduledoc """
  Documentation for `Lister`.
  """

  defprotocol Listable do
    @spec show(any()) :: any()
    def show(term)
  end

  defimpl Listable, for: BitString do
    @spec show(binary()) :: list()
    def show(term) do
      if is_nil(term) do
        [nil]
      else
        String.to_charlist(term)
      end
    end
  end

  defimpl Listable, for: List do
    @spec show(list()) :: list()
    def show(term) do
      term
    end
  end

  defimpl Listable, for: [Float, Integer] do
    @spec show(integer()) :: [...]
    def show(term) do
      [term]
    end
  end

  defimpl Listable, for: Map do
    def show(term) do
      term |> Map.to_list()
    end
  end

  defimpl Listable, for: Tuple do
    def show(term) do
      term |> Tuple.to_list()
    end
  end

  defimpl Listable, for: Atom do
    @spec show(atom()) :: list()
    def show(term) do
      [term]
    end
  end

  def show(term) do
    Listable.show(term)
  end
end
