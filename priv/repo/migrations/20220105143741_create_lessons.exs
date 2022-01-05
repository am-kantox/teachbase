defmodule Teachbase.Repo.Migrations.CreateLessons do
  use Ecto.Migration

  def change do
    create table(:lessons) do
      add :name, :string
      add :description, :string
      add :reference, :string
      add :teacher_id, :integer

      timestamps()
    end
  end
end
