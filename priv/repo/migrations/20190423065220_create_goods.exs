defmodule TrunkFunk.Repo.Migrations.CreateGoods do
  use Ecto.Migration

  def change do
    create table(:goods) do
      add :name, :string
      add :description, :string
      add :price, :string

      timestamps()
    end

  end
end
