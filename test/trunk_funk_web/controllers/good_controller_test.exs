defmodule TrunkFunkWeb.GoodControllerTest do
  use TrunkFunkWeb.ConnCase

  alias TrunkFunk.Merch

  @create_attrs %{description: "some description", name: "some name", price: "some price"}
  @update_attrs %{description: "some updated description", name: "some updated name", price: "some updated price"}
  @invalid_attrs %{description: nil, name: nil, price: nil}

  def fixture(:good) do
    {:ok, good} = Merch.create_good(@create_attrs)
    good
  end

  describe "index" do
    test "lists all goods", %{conn: conn} do
      conn = get(conn, Routes.good_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Goods"
    end
  end

  describe "new good" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.good_path(conn, :new))
      assert html_response(conn, 200) =~ "New Good"
    end
  end

  describe "create good" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.good_path(conn, :create), good: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.good_path(conn, :show, id)

      conn = get(conn, Routes.good_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Good"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.good_path(conn, :create), good: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Good"
    end
  end

  describe "edit good" do
    setup [:create_good]

    test "renders form for editing chosen good", %{conn: conn, good: good} do
      conn = get(conn, Routes.good_path(conn, :edit, good))
      assert html_response(conn, 200) =~ "Edit Good"
    end
  end

  describe "update good" do
    setup [:create_good]

    test "redirects when data is valid", %{conn: conn, good: good} do
      conn = put(conn, Routes.good_path(conn, :update, good), good: @update_attrs)
      assert redirected_to(conn) == Routes.good_path(conn, :show, good)

      conn = get(conn, Routes.good_path(conn, :show, good))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, good: good} do
      conn = put(conn, Routes.good_path(conn, :update, good), good: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Good"
    end
  end

  describe "delete good" do
    setup [:create_good]

    test "deletes chosen good", %{conn: conn, good: good} do
      conn = delete(conn, Routes.good_path(conn, :delete, good))
      assert redirected_to(conn) == Routes.good_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.good_path(conn, :show, good))
      end
    end
  end

  defp create_good(_) do
    good = fixture(:good)
    {:ok, good: good}
  end
end
