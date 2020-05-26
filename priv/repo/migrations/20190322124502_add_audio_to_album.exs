defmodule TrunkFunk.Repo.Migrations.AddAudioToAlbum do
  use Ecto.Migration

  def change do
    alter table(:albums) do      
      add :audio, :string
    end 
  end
end
