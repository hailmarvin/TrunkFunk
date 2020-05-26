defmodule TrunkFunk.CommentsChannel do
  use TrunkFunkWeb, :channel
  import TrunkFunk.Core
  alias TrunkFunk.Core.Comment
  alias TrunkFunk.Repo

  def join("comments:" <> album_id, _params, socket) do
    album_id = String.to_integer(album_id)
    album = get_album!(album_id) |> Repo.preload(comments: [:user])
    {:ok, %{comments: album.comments}, assign(socket, :album, album)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    album = socket.assigns.album
    user_id = socket.assigns.user_id

    changeset = album 
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.album.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}  
    end    
  end
end