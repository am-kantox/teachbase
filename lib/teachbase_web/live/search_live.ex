defmodule TeachbaseWeb.SearchLive do
  use TeachbaseWeb, :live_view

  alias Teachbase.Courses

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", lessons: [])}
  end

  def handle_event("change-input", %{"query" => query}, socket) do
    case query do
      "" -> {:noreply, assign(socket, query: query, lessons: [])}
      query -> {:noreply, assign(socket, query: query, lessons: Courses.search_lessons(query))}
    end
  end
end
