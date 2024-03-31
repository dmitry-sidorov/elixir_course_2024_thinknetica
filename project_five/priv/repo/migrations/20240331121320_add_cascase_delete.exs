defmodule ProjectFive.Repo.Migrations.AddCascaseDelete do
  use Ecto.Migration

  def change do
    alter table(:enrolments) do
      modify :student_id, references(:students, on_delete: :delete_all),
        from: references(:students)

      modify :course_id, references(:courses, on_delete: :delete_all), from: references(:courses)
    end
  end
end
