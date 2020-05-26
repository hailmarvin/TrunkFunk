defmodule TrunkFunk.Merch.Photo do
    use Ecto.Schema
    import Ecto.Changeset
  
  
    schema "merch_photos" do
      field :image, :string
  
      
      belongs_to :good, TrunkFunk.Merch.Good
      timestamps()
    end
  
    @doc false
    def changeset(photo, attrs) do
      photo
      |> cast(attrs, [:image])
      |> validate_required([:image])
    end
  end
  