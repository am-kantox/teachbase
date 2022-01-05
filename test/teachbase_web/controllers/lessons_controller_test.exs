defmodule TeachbaseWeb.LessonsControllerTest do
  use TeachbaseWeb.ConnCase

  import Teachbase.CoursesFixtures

  alias Teachbase.Courses.Lesson

  @create_attrs %{
    description: "some description",
    name: "some name",
    reference: "some reference",
    teacher: Teachbase.AccountsFixtures.valid_user_attributes()
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    reference: "some updated reference"
  }
  @invalid_attrs %{description: nil, name: nil, reference: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lessons", %{conn: conn} do
      conn = get(conn, Routes.lessons_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create lessons" do
    test "renders lessons when data is valid", %{conn: conn} do
      conn = post(conn, Routes.lessons_path(conn, :create), lessons: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.lessons_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "name" => "some name",
               "reference" => "some reference",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.lessons_path(conn, :create), lessons: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update lessons" do
    setup [:create_lessons]

    test "renders lessons when data is valid", %{conn: conn, lessons: %Lesson{id: id} = lessons} do
      conn = put(conn, Routes.lessons_path(conn, :update, lessons), lessons: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.lessons_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "name" => "some updated name",
               "reference" => "some updated reference",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, lessons: lessons} do
      conn = put(conn, Routes.lessons_path(conn, :update, lessons), lessons: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete lessons" do
    setup [:create_lessons]

    test "deletes chosen lessons", %{conn: conn, lessons: lessons} do
      conn = delete(conn, Routes.lessons_path(conn, :delete, lessons))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.lessons_path(conn, :show, lessons))
      end
    end
  end

  defp create_lessons(_) do
    lessons = lessons_fixture()
    %{lessons: lessons}
  end
end
