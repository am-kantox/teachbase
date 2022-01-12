defmodule Teachbase.Repo.Migrations.CreateLessonsAttendants do
  use Ecto.Migration

  def change do
    create table(:lessons_attendants) do
      add :lesson_id, references(:lessons)
      add :user_id, references(:users)
    end

    create unique_index(:lessons_attendants, [:lesson_id, :user_id])
  end
end
