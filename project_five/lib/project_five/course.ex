defmodule ProjectFive.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectFive.{Enrolment, Student}

  schema "courses" do
    field(:title, :string)
    many_to_many(:students, Student, join_through: Enrolment)

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
