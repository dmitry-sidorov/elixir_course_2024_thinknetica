defmodule ProjectFive.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectFive.Courses` context.
  """

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> ProjectFive.Courses.create_course()

    course
  end
end
