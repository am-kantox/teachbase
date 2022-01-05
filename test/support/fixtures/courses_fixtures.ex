defmodule Teachbase.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Teachbase.Courses` context.
  """

  @doc """
  Generate a lessons.
  """
  def lessons_fixture(attrs \\ %{}) do
    {:ok, lessons} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        reference: "some reference",
        teacher: Teachbase.AccountsFixtures.valid_user_attributes()
      })
      |> Teachbase.Courses.create_lessons()

    lessons
  end
end
