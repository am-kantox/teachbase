defmodule TeachbaseWeb.LessonsView do
  use TeachbaseWeb, :view
  alias TeachbaseWeb.LessonsView

  def render("index.json", %{lessons: lessons}) do
    %{data: render_many(lessons, LessonsView, "lessons.json")}
  end

  def render("show.json", %{lessons: lessons}) do
    %{data: render_one(lessons, LessonsView, "lessons.json")}
  end

  def render("lessons.json", %{lessons: lessons}) do
    %{
      id: lessons.id,
      name: lessons.name,
      description: lessons.description,
      reference: lessons.reference,
      teacher: lessons.teacher
    }
  end
end
