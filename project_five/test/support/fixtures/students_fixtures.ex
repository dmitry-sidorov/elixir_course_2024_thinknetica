defmodule ProjectFive.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectFive.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> ProjectFive.Students.create_student()

    student
  end
end
