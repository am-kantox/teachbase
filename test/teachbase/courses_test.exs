defmodule Teachbase.CoursesTest do
  use Teachbase.DataCase

  alias Teachbase.Courses

  describe "lessons" do
    alias Teachbase.Courses.Lesson

    import Teachbase.CoursesFixtures

    @invalid_attrs %{description: nil, name: nil, reference: nil}

    test "list_lessons/0 returns all lessons" do
      lessons = lessons_fixture()
      assert Courses.list_lessons() == [lessons]
    end

    test "get_lessons!/1 returns the lessons with given id" do
      lessons = lessons_fixture()
      assert Courses.get_lessons!(lessons.id) == lessons
    end

    test "create_lessons/1 with valid data creates a lessons" do
      valid_attrs = %{description: "some description", name: "some name", reference: "some reference", teacher: Teachbase.AccountsFixtures.valid_user_attributes()}

      assert {:ok, %Lesson{} = lessons} = Courses.create_lessons(valid_attrs)
      assert lessons.description == "some description"
      assert lessons.name == "some name"
      assert lessons.reference == "some reference"
    end

    test "create_lessons/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_lessons(@invalid_attrs)
    end

    test "update_lessons/2 with valid data updates the lessons" do
      lessons = lessons_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", reference: "some updated reference"}

      assert {:ok, %Lesson{} = lessons} = Courses.update_lessons(lessons, update_attrs)
      assert lessons.description == "some updated description"
      assert lessons.name == "some updated name"
      assert lessons.reference == "some updated reference"
    end

    test "update_lessons/2 with invalid data returns error changeset" do
      lessons = lessons_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_lessons(lessons, @invalid_attrs)
      assert lessons == Courses.get_lessons!(lessons.id)
    end

    test "delete_lessons/1 deletes the lessons" do
      lessons = lessons_fixture()
      assert {:ok, %Lesson{}} = Courses.delete_lessons(lessons)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_lessons!(lessons.id) end
    end

    test "change_lessons/1 returns a lessons changeset" do
      lessons = lessons_fixture()
      assert %Ecto.Changeset{} = Courses.change_lessons(lessons)
    end
  end
end
