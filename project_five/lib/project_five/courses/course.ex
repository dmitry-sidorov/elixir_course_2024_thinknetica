defmodule ProjectFive.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
