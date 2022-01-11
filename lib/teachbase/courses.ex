defmodule Teachbase.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias Teachbase.Repo

  alias Teachbase.Courses.Lesson

  @doc """
  Returns the list of lessons.

  ## Examples

      iex> list_lessons()
      [%Lesson{}, ...]

  """
  def list_lessons do
    Repo.all(from l in Lesson, preload: [:teacher, :attendants])
  end

  @doc """
  Gets a single lessons.

  Raises `Ecto.NoResultsError` if the Lessons does not exist.

  ## Examples

      iex> get_lessons!(123)
      %Lesson{}

      iex> get_lessons!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lessons!(id), do: Lesson |> Repo.get!(id) |> Repo.preload([:teacher, :attendants])

  @doc """
  Creates a lessons.

  ## Examples

      iex> create_lessons(%{field: value})
      {:ok, %Lesson{}}

      iex> create_lessons(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lessons(attrs \\ %{}) do
    %Lesson{}
    |> Lesson.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lessons.

  ## Examples

      iex> update_lessons(lessons, %{field: new_value})
      {:ok, %Lesson{}}

      iex> update_lessons(lessons, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lessons(%Lesson{} = lessons, attrs) do
    lessons
    |> Lesson.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lessons.

  ## Examples

      iex> delete_lessons(lessons)
      {:ok, %Lesson{}}

      iex> delete_lessons(lessons)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lessons(%Lesson{} = lessons) do
    Repo.delete(lessons)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lessons changes.

  ## Examples

      iex> change_lessons(lessons)
      %Ecto.Changeset{data: %Lesson{}}

  """
  def change_lessons(%Lesson{} = lessons, attrs \\ %{}) do
    Lesson.changeset(lessons, attrs)
  end

  @doc """
  Adds attendant to lesson
  """
  def add_attendant_to_lesson(lesson, attendant) do
    lesson
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:attendants, [attendant | lesson.attendants])
    |> Repo.update!
  end

  @doc """
  Returns list of attendants by teacher
  """
  def list_attendants_by_teacher(teacher) do
    query =
      from lesson in Lesson,
      where: lesson.teacher_id == ^teacher.id,
      join: user in assoc(lesson, :attendants),
      select: user

    Repo.all(query)
  end

  @doc """
  Returns list of lessons by attendants count
  """
  def list_lessons_by_attendants_count(count) do
    query =
      from lesson in Lesson,
      join: user in assoc(lesson, :attendants),
      group_by: [lesson.id],
      having: count(user.id) > ^count,
      select: lesson

    Repo.all(query)
  end

  @doc """
  Returns list of lessons by name template
  """
  def list_lessons_by_name_template(template) do
    query =
      from lesson in Lesson,
      where: like(lesson.name, ^template),
      select: lesson

    Repo.all(query)
  end

  @doc """
  Returns list of lessons by text
  """
  def search_lessons(text) do
    template = "%#{text}%"

    query =
      from lesson in Lesson,
      where: like(lesson.name, ^template) or like(lesson.description, ^template),
      select: lesson

    Repo.all(query)
  end
end
