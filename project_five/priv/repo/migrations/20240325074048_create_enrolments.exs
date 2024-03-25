defmodule ProjectFive.Repo.Migrations.CreateEnrolments do
  use Ecto.Migration

  def change do
    create table(:enrolments) do
      add :grade, :float
      add :year, :integer
      add :student_id, references(:students)
      add :course_id, references(:courses)

      timestamps()
    end

    create index(:enrolments, [:student_id])
    create index(:enrolments, [:course_id])
  end
end
