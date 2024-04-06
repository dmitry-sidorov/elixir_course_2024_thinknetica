defmodule Lister do
  @moduledoc """
  Documentation for `Lister`.

  """

  defprotocol Listable do
    @spec show(any()) :: list()
    @fallback_to_any true
    def show(term)
  end

  defimpl Listable, for: [String, BitString] do
    @spec show(binary()) :: list()
    def show(term) do
      term |> String.to_charlist()
    end
  end

  defimpl Listable, for: List do
    @spec show(list()) :: list()
    def show(term) do
      term
    end
  end

  defimpl Listable, for: [Float, Integer] do
    @spec show(integer()) :: list(integer() | float())
    def show(term) do
      [term]
    end
  end

  # Any type handles custom user structs.
  defimpl Listable, for: [Map, Any] do
    @spec show(map()) :: list({any(), any()})
    def show(term) do
      term |> Map.to_list()
    end
  end

  defimpl Listable, for: Tuple do
    @spec show(tuple()) :: list(any())
    def show(term) do
      term |> @for.to_list()
    end
  end

  defimpl Listable, for: Atom do
    @spec show(atom()) :: list(atom())
    def show(term) do
      [term]
    end
  end

  @doc """
  Converts any given value to list.

  ## Examples
      iex> Lister.show(%{hello: "map", whats: "up"})
      [hello: "map", whats: "up"]
  """
  def show(term) do
    Listable.show(term)
  end
end
