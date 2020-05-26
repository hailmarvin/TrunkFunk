defmodule TrunkFunk.Repo.Migrations.AddUserIdToAlbum do
  use Ecto.Migration

  def change do
    alter table(:albums) do      
      add :user_id, references(:users, on_delete: :nothing)
    end  

    
    create index(:albums, [:user_id])
  end
end
