defmodule TrunkFunk.Repo.Migrations.CreateMerchPhotos do
  use Ecto.Migration

  def change do
    create table "merch_photos" do      
      add :image, :string
      add :good_id, references(:goods)

      timestamps()
    end

    create index(:merch_photos, [:good_id])
  end
end
