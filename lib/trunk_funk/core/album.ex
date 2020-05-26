defmodule TrunkFunk.Core.Album do
  use Ecto.Schema
  import Ecto.Changeset  
  use Arc.Ecto.Schema

  schema "albums" do
    field :image, TrunkFunk.Album.Type
    field :name, :string
    field :audio, TrunkFunk.Audio.Type
    field :artist, :string
    field :featuring, :string

    belongs_to :user, TrunkFunk.Accounts.User
    has_many :comments, TrunkFunk.Core.Comment
    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name, :user_id, :artist, :featuring])    
    |> cast_attachments(attrs, [:image, :audio])
    |> validate_required([:name, :image, :audio, :user_id, :artist])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:user_id)
  end
end
