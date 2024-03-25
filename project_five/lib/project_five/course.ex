defmodule ProjectFive.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field(:title, :string)
    has_many(:enrolments, ProjectFive.Enrolment)

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
