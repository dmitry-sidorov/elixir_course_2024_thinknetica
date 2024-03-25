defmodule ProjectFive.Enrolements do
  @moduledoc """
  The Enrolements context.
  """

  import Ecto.Query, warn: false
  alias ProjectFive.Repo

  alias ProjectFive.Enrolements.Enrolment

  @doc """
  Returns the list of enrolments.

  ## Examples

      iex> list_enrolments()
      [%Enrolment{}, ...]

  """
  def list_enrolments do
    Repo.all(Enrolment)
  end

  @doc """
  Gets a single enrolment.

  Raises `Ecto.NoResultsError` if the Enrolment does not exist.

  ## Examples

      iex> get_enrolment!(123)
      %Enrolment{}

      iex> get_enrolment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enrolment!(id), do: Repo.get!(Enrolment, id)

  @doc """
  Creates a enrolment.

  ## Examples

      iex> create_enrolment(%{field: value})
      {:ok, %Enrolment{}}

      iex> create_enrolment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enrolment(attrs \\ %{}) do
    %Enrolment{}
    |> Enrolment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enrolment.

  ## Examples

      iex> update_enrolment(enrolment, %{field: new_value})
      {:ok, %Enrolment{}}

      iex> update_enrolment(enrolment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enrolment(%Enrolment{} = enrolment, attrs) do
    enrolment
    |> Enrolment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a enrolment.

  ## Examples

      iex> delete_enrolment(enrolment)
      {:ok, %Enrolment{}}

      iex> delete_enrolment(enrolment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enrolment(%Enrolment{} = enrolment) do
    Repo.delete(enrolment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enrolment changes.

  ## Examples

      iex> change_enrolment(enrolment)
      %Ecto.Changeset{data: %Enrolment{}}

  """
  def change_enrolment(%Enrolment{} = enrolment, attrs \\ %{}) do
    Enrolment.changeset(enrolment, attrs)
  end
end
