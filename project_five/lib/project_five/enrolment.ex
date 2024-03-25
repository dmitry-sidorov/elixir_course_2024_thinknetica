defmodule ProjectFive.Enrolment do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectFive.{Course, Student}

  schema "enrolments" do
    field(:grade, :float)
    belongs_to(:student, Student)
    belongs_to(:course, Course)

    timestamps()
  end

  @doc false
  def changeset(enrolment, attrs) do
    enrolment
    |> cast(attrs, [:grade])
    |> validate_required([:grade])
  end
end
