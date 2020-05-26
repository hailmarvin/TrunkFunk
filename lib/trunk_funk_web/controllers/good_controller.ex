defmodule TrunkFunkWeb.GoodController do
  use TrunkFunkWeb, :controller

  alias TrunkFunk.Merchs
  alias TrunkFunk.Merch.Good  
  plug :authenticate_admin, [pokerface: true] when action in [:new , :create, :edit, :update, :delete] 

  def index(conn, _params) do
    goods = Merchs.list_goods()
    render(conn, "index.html", goods: goods)
  end

  def new(conn, _params) do
    changeset = Merchs.change_good(%Good{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"good" => good_params}) do
    case Merchs.create_good(good_params) do
      {:ok, good} ->
        conn
        |> put_flash(:info, "Merch created successfully.")
        |> redirect(to: Routes.good_path(conn, :show, good))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    good = Merchs.get_good!(id)
    render(conn, "show.html", good: good)
  end

  def edit(conn, %{"id" => id}) do
    good = Merchs.get_good!(id)
    changeset = Merchs.change_good(good)
    render(conn, "edit.html", good: good, changeset: changeset)
  end

  def update(conn, %{"id" => id, "good" => good_params}) do
    good = Merchs.get_good!(id)

    case Merchs.update_good(good, good_params) do
      {:ok, good} ->
        conn
        |> put_flash(:info, "Merch updated successfully.")
        |> redirect(to: Routes.good_path(conn, :show, good))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", good: good, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    good = Merchs.get_good!(id)
    {:ok, _good} = Merchs.delete_good(good)

    conn
    |> put_flash(:info, "Merch deleted successfully.")
    |> redirect(to: Routes.good_path(conn, :index))
  end
end
