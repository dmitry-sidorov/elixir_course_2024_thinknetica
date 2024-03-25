defmodule ProjectFive.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :title, :string
      add :description, :text

      timestamps()
    end
  end
end
