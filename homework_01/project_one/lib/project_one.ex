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
  def calculate_chmod(perm) do
    user = Map.get(perm, :user)
    group = Map.get(perm, :group)
    other = Map.get(perm, :other)
    "#{calculate_permission(user)}#{calculate_permission(group)}#{calculate_permission(other)}"
  end

  defp calculate_permission(nil), do: "0"
  defp calculate_permission(code) do
    {num, _} = code
    |> String.replace(~r/\w/, "1")
    |> String.replace(~r/-/, "0")
    |> Integer.parse(2)

    num
  end
end
