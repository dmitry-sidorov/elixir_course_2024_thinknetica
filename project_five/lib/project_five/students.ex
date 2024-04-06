defmodule ProjectFive.Students do
  @moduledoc """
  The Students context.
  """

  import Ecto.Query, warn: false
  alias ProjectFive.Repo

  alias ProjectFive.Students.Student

  @doc """
  Returns the list of students.
  """
  def list_students do
    Repo.all(Student) |> Repo.preload([:courses])
  end

  @doc """
  Gets a single student.

  Raises `Ecto.NoResultsError` if the Student does not exist.
  """
  def get_student!(id), do: Repo.get!(Student, id)

  @doc """
  Creates a student.
  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student.
  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student.
  """
  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student changes.
  """
  def change_student(%Student{} = student, attrs \\ %{}) do
    Student.changeset(student, attrs)
  end
end
