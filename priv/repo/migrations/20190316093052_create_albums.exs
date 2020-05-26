defmodule TrunkFunk.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:albums, [:name])
  end
end
