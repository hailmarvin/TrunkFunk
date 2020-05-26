defmodule TrunkFunk.Merch.Good do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goods" do
    field :description, :string
    field :name, :string
    field :price, :string

    
    has_one :merch_photos, TrunkFunk.Merch.Photo, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(good, attrs) do
    good
    |> cast(attrs, [:name, :description, :price])
    |> validate_required([:name, :description, :price])
  end
end
