defmodule ProjectFive.Repo.Migrations.CreateEnrolments do
  use Ecto.Migration

  def change do
    create table(:enrolments) do
      add :grade, :float
      add :student_id, references(:students, on_delete: :nothing)
      add :course_id, references(:courses, on_delete: :nothing)

      timestamps()
    end

    create index(:enrolments, [:student_id])
    create index(:enrolments, [:course_id])
  end
end
