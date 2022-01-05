defmodule TeachbaseWeb.PageController do
  use TeachbaseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
