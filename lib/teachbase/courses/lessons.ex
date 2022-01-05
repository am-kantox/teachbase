defmodule Teachbase.Courses.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  alias Teachbase.Accounts.User, as: Teacher

  schema "lessons" do
    field :description, :string
    field :name, :string
    field :reference, :string
    belongs_to :teacher, Teacher

    timestamps()
  end

  @doc false
  def changeset(lessons, attrs) do
    lessons
    |> cast(attrs, [:name, :description, :reference])
    |> cast_assoc(:teacher, with: &Teacher.registration_changeset/2)
    |> validate_required([:name, :description, :reference, :teacher])
  end
end
