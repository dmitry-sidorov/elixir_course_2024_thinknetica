defmodule ProjectFive.Enrolements do
  @moduledoc """
  The Enrolements context.
  """

  import Ecto.Query, warn: false
  alias ProjectFive.Repo

  alias ProjectFive.{Courses.Course, Enrolements.Enrolment, Students.Student}

  @doc """
  Returns the list of enrolments.
  """
  def list_enrolments do
    Enrolment
    |> Repo.all()
    |> Repo.preload([:student, :course])
  end

  @doc """
  Creates a enrolment.
  """
  def create_enrolment(attrs \\ %{}) do
    %Enrolment{}
    |> Enrolment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enrolment.
  """
  def update_enrolment(%Enrolment{} = enrolment, attrs) do
    enrolment
    |> Enrolment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a enrolment.
  """
  def delete_enrolment(%Student{} = student, %Course{} = course) do
    Enrolements.list_enrolments()
    # Repo.delete(enrolment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enrolment changes.
  """
  def change_enrolment(%Enrolment{} = enrolment, attrs \\ %{}) do
    Enrolment.changeset(enrolment, attrs)
  end
end
