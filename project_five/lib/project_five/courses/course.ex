defmodule ProjectFive.Courses.Course do
  alias ProjectFive.{Students.Student, Enrolements.Enrolment}
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :description, :string
    field :title, :string
    many_to_many :students, Student, join_through: Enrolment

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
