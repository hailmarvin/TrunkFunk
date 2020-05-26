defmodule TrunkFunk.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table "comments" do      
      add :content, :string
      add :user_id, references(:users)
      add :album_id, references(:albums)

      timestamps()
    end

    create index(:comments, [:user_id, :album_id])
  end
end
