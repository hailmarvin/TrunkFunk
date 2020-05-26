defmodule TrunkFunk.Repo.Migrations.AddArtistAndFeaturesToAlbum do
  use Ecto.Migration

  def change do
    alter table(:albums) do
      add :artist, :string
      add :featuring, :string
    end
  end
end
