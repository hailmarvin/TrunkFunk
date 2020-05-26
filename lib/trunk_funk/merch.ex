defmodule TrunkFunk.Merchs do
  import Ecto.Query, warn: false
  alias TrunkFunk.Repo

  alias TrunkFunk.Merch.Good
  alias TrunkFunk.Merch.Photo

  def list_goods do
    Repo.all(Good)
  end

  def get_good!(id), do: Repo.get!(Good, id)

  def create_good(attrs \\ %{}) do
    %Good{}
    |> Good.changeset(attrs)
    |> Repo.insert()
  end

  def update_good(%Good{} = good, attrs) do
    good
    |> Good.changeset(attrs)
    |> Repo.update()
  end

  def delete_good(%Good{} = good) do
    Repo.delete(good)
  end

  def change_good(%Good{} = good) do
    Good.changeset(good, %{})
  end

  def list_photo do
    Repo.all(Photo)
  end

  def get_photo!(id), do: Repo.get!(Photo, id)

  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  def change_photo(%Photo{} = photo) do
    Photo.changeset(photo, %{})
  end
end
