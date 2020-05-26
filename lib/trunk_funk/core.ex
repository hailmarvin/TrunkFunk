defmodule TrunkFunk.Core do

  import Ecto.Query, warn: false
  alias TrunkFunk.Repo

  alias TrunkFunk.Core.Album

  def list_albums do
    Repo.all(Album)
  end

  def get_album!(id), do: Repo.get!(Album, id) |> Repo.preload([:user]) 

  def get_album_by_name(name) do
    Repo.get_by!(Album, %{name: name})
    |> Repo.preload([:user])
  end    

  def create_album(attrs \\ %{}) do
    %Album{}
    |> Album.changeset(attrs)
    |> Repo.insert()
  end

  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> Repo.update()
  end

  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  def delete_by_name(name) do
    Repo.get_by!(Album, %{name: name})
    |> Repo.delete
  end

  def change_album(%Album{} = album) do
    Album.changeset(album, %{})
  end
end
