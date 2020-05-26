defmodule TrunkFunk.Core.Comment do
use Ecto.Schema
import Ecto.Changeset

@derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string

    belongs_to :user, TrunkFunk.Accounts.User
    belongs_to :album, TrunkFunk.Core.Album
    timestamps()
  end

  def changeset(comment, attrs) do
    comment 
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end