defmodule TeachbaseWeb.LessonsController do
  use TeachbaseWeb, :controller

  alias Teachbase.Courses
  alias Teachbase.Courses.Lesson

  action_fallback TeachbaseWeb.FallbackController

  def index(conn, _params) do
    lessons = Courses.list_lessons()
    render(conn, "index.json", lessons: lessons)
  end

  def create(conn, %{"lessons" => lessons_params}) do
    with {:ok, %Lesson{} = lessons} <- Courses.create_lessons(lessons_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.lessons_path(conn, :show, lessons))
      |> render("show.json", lessons: lessons)
    end
  end

  def show(conn, %{"id" => id}) do
    lessons = Courses.get_lessons!(id)
    render(conn, "show.json", lessons: lessons)
  end

  def update(conn, %{"id" => id, "lessons" => lessons_params}) do
    lessons = Courses.get_lessons!(id)

    with {:ok, %Lesson{} = lessons} <- Courses.update_lessons(lessons, lessons_params) do
      render(conn, "show.json", lessons: lessons)
    end
  end

  def delete(conn, %{"id" => id}) do
    lessons = Courses.get_lessons!(id)

    with {:ok, %Lesson{}} <- Courses.delete_lessons(lessons) do
      send_resp(conn, :no_content, "")
    end
  end
end
