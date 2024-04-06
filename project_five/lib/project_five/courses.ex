defmodule ProjectFive.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias ProjectFive.Repo

  alias ProjectFive.Courses.Course

  @doc """
  Returns the list of courses.
  """
  def list_courses do
    Repo.all(Course)
    |> Repo.preload([:students])
  end

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.
  """
  def get_course!(id), do: Repo.get!(Course, id)

  @doc """
  Creates a course.
  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a course.
  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a course.
  """
  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course changes.
  """
  def change_course(%Course{} = course, attrs \\ %{}) do
    Course.changeset(course, attrs)
  end
end
