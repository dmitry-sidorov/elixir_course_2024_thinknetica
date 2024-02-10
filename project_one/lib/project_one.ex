defmodule ProjectOne do
  @moduledoc """
  Documentation for `ProjectOne`.
  """

  @doc """
  Hello chmod.

  ## Examples

      iex> ProjectOne.calculate_chmod(%{user: "rwx", group: "r-x", other: "r-x"})
      "755"

  """
  @code_length 3

  def calculate_chmod(perm) do
    user = Map.get(perm, :user)
    group = Map.get(perm, :group)
    other = Map.get(perm, :other)

    [user, group, other]
    |> Enum.map(&calculate_permission/1)
    |> Enum.join()
  end

  defp calculate_permission(nil), do: "0"

  defp calculate_permission(code) do
    case String.length(code) do
      @code_length -> parse_code(code)
      _ -> raise "Wrong length of charset (should be #{@code_length})"
    end
  end

  defp parse_code(code) do
    {num, _} =
      code
      |> String.graphemes()
      |> Enum.map(&parse_grapheme/1)
      |> Enum.join()
      |> Integer.parse(2)

    num
  end

  defp parse_grapheme(grapheme) do
    cond do
      grapheme |> String.match?(~r/r|w|x/) -> "1"
      grapheme |> String.match?(~r/-/) -> "0"
      true -> raise "Char is not allowed! (r, w, x, -)"
    end
  end
end
