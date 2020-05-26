defmodule TrunkFunk.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:username]}

  schema "users" do
    field :name, :string
    field :username, :string

    has_one :credential, TrunkFunk.Accounts.Credential, on_delete: :delete_all
    has_many :albums, TrunkFunk.Core.Album, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
