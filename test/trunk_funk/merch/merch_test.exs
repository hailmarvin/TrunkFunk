defmodule TrunkFunk.MerchTest do
  use TrunkFunk.DataCase

  alias TrunkFunk.Merch

  describe "goods" do
    alias TrunkFunk.Merch.Good

    @valid_attrs %{description: "some description", name: "some name", price: "some price"}
    @update_attrs %{description: "some updated description", name: "some updated name", price: "some updated price"}
    @invalid_attrs %{description: nil, name: nil, price: nil}

    def good_fixture(attrs \\ %{}) do
      {:ok, good} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Merch.create_good()

      good
    end

    test "list_goods/0 returns all goods" do
      good = good_fixture()
      assert Merch.list_goods() == [good]
    end

    test "get_good!/1 returns the good with given id" do
      good = good_fixture()
      assert Merch.get_good!(good.id) == good
    end

    test "create_good/1 with valid data creates a good" do
      assert {:ok, %Good{} = good} = Merch.create_good(@valid_attrs)
      assert good.description == "some description"
      assert good.name == "some name"
      assert good.price == "some price"
    end

    test "create_good/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Merch.create_good(@invalid_attrs)
    end

    test "update_good/2 with valid data updates the good" do
      good = good_fixture()
      assert {:ok, %Good{} = good} = Merch.update_good(good, @update_attrs)
      assert good.description == "some updated description"
      assert good.name == "some updated name"
      assert good.price == "some updated price"
    end

    test "update_good/2 with invalid data returns error changeset" do
      good = good_fixture()
      assert {:error, %Ecto.Changeset{}} = Merch.update_good(good, @invalid_attrs)
      assert good == Merch.get_good!(good.id)
    end

    test "delete_good/1 deletes the good" do
      good = good_fixture()
      assert {:ok, %Good{}} = Merch.delete_good(good)
      assert_raise Ecto.NoResultsError, fn -> Merch.get_good!(good.id) end
    end

    test "change_good/1 returns a good changeset" do
      good = good_fixture()
      assert %Ecto.Changeset{} = Merch.change_good(good)
    end
  end
end
