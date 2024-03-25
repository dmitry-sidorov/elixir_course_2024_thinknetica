defmodule ProjectFive.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
