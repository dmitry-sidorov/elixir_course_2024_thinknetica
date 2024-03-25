defmodule ProjectFive.Students.Student do
  alias ProjectFive.{Courses.Course, Enrolements.Enrolment}
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :first_name, :string
    field :last_name, :string
    many_to_many :courses, Course, join_through: Enrolment

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
