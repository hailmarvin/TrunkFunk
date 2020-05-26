defmodule TrunkFunkWeb.AlbumController do
  use TrunkFunkWeb, :controller

  alias TrunkFunk.Core
  alias TrunkFunk.Core.Album
  plug :authenticate_admin, [pokerface: true] when action in [:new , :create] 

  def index(conn, _params) do
    albums = Core.list_albums()
    render(conn, "index.html", albums: albums)
  end

  def new(conn, _params) do
    changeset = Core.change_album(%Album{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: current}} = conn,
             %{"album" => album_params}) do

    params = Map.put(album_params, "user_id", current.id)

    case Core.create_album(params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album created successfully.")
        |> redirect(to: Routes.album_path(conn, :show, album.name))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
        conn
        |> halt()
    end
  end

  def show(conn, %{"id" => name}) do
    album = Core.get_album_by_name(name)
    render(conn, "show.html", album: album)
  end

  def edit(conn, %{"id" => name}) do
    album = Core.get_album_by_name(name)
    changeset = Core.change_album(album)
    render(conn, "edit.html", album: album, changeset: changeset)
  end

  def update(%{assigns: %{current_user: current}} = conn,
             %{"id" => name, "album" => album_params}) do
    album = Core.get_album_by_name(name)
    params = Map.put_new(album_params, "user_id", current.id)

    case Core.update_album(album, params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album updated successfully.")
        |> redirect(to: Routes.album_path(conn, :show, album.name))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", album: album, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => name}) do
    {:ok, _album} = Core.delete_by_name(name)

    conn
    |> put_flash(:info, "Album deleted successfully.")
    |> redirect(to: Routes.album_path(conn, :index))
  end
end
