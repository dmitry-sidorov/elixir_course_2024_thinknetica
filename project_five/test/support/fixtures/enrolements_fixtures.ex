defmodule ProjectFive.EnrolementsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProjectFive.Enrolements` context.
  """

  @doc """
  Generate a enrolment.
  """
  def enrolment_fixture(attrs \\ %{}) do
    {:ok, enrolment} =
      attrs
      |> Enum.into(%{
        grade: 120.5,
        year: 42
      })
      |> ProjectFive.Enrolements.create_enrolment()

    enrolment
  end
end
