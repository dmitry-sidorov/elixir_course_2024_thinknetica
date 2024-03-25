defmodule ProjectFive.Enrolements.Enrolment do
  alias ProjectFive.{Courses.Course, Students.Student}
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrolments" do
    field :year, :integer
    field :grade, :float
    belongs_to :student, Student
    belongs_to :course, Course

    timestamps()
  end

  @doc false
  def changeset(enrolment, attrs) do
    enrolment
    |> cast(attrs, [:grade, :year])
    |> validate_required([:grade, :year])
  end
end
