defmodule Teachbase.Courses.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  alias Teachbase.Accounts.User

  schema "lessons" do
    field :description, :string
    field :name, :string
    field :reference, :string

    belongs_to :teacher, User
    many_to_many :attendants, User, join_through: "lessons_attendants"

    timestamps()
  end

  @doc false
  def changeset(lessons, attrs) do
    lessons
    |> cast(attrs, [:name, :description, :reference])
    |> cast_assoc(:teacher, with: &User.registration_changeset/2)
    |> validate_required([:name, :description, :reference, :teacher])
  end
end

# create lesson Ecto.build_assoc(u, :lessons) |> Ecto.Changeset.change(l2_data) |> Teachbase.Repo.insert!()
# list lessons Courses.list_lessons |> Teachbase.Repo.preload(:teacher)

# add attendarts l1 |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:attendants, [u2, u3]) |> Repo.update!

# Repo.all(from lesson in Lesson, where: lesson.teacher_id == ^u.id, join: user in assoc(lesson, :attendants), select: user)
