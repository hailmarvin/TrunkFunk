defmodule TrunkFunk.CoreTest do
  use TrunkFunk.DataCase

  alias TrunkFunk.Core

  describe "albums" do
    alias TrunkFunk.Core.Album

    @valid_attrs %{image: "some image", name: "some name"}
    @update_attrs %{image: "some updated image", name: "some updated name"}
    @invalid_attrs %{image: nil, name: nil}

    def album_fixture(attrs \\ %{}) do
      {:ok, album} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_album()

      album
    end

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Core.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Core.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      assert {:ok, %Album{} = album} = Core.create_album(@valid_attrs)
      assert album.image == "some image"
      assert album.name == "some name"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      assert {:ok, %Album{} = album} = Core.update_album(album, @update_attrs)
      assert album.image == "some updated image"
      assert album.name == "some updated name"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_album(album, @invalid_attrs)
      assert album == Core.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Core.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Core.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Core.change_album(album)
    end
  end

  describe "sounds" do
    alias TrunkFunk.Core.Sound

    @valid_attrs %{name: "some name", song: "some song"}
    @update_attrs %{name: "some updated name", song: "some updated song"}
    @invalid_attrs %{name: nil, song: nil}

    def sound_fixture(attrs \\ %{}) do
      {:ok, sound} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_sound()

      sound
    end

    test "list_sounds/0 returns all sounds" do
      sound = sound_fixture()
      assert Core.list_sounds() == [sound]
    end

    test "get_sound!/1 returns the sound with given id" do
      sound = sound_fixture()
      assert Core.get_sound!(sound.id) == sound
    end

    test "create_sound/1 with valid data creates a sound" do
      assert {:ok, %Sound{} = sound} = Core.create_sound(@valid_attrs)
      assert sound.name == "some name"
      assert sound.song == "some song"
    end

    test "create_sound/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_sound(@invalid_attrs)
    end

    test "update_sound/2 with valid data updates the sound" do
      sound = sound_fixture()
      assert {:ok, %Sound{} = sound} = Core.update_sound(sound, @update_attrs)
      assert sound.name == "some updated name"
      assert sound.song == "some updated song"
    end

    test "update_sound/2 with invalid data returns error changeset" do
      sound = sound_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_sound(sound, @invalid_attrs)
      assert sound == Core.get_sound!(sound.id)
    end

    test "delete_sound/1 deletes the sound" do
      sound = sound_fixture()
      assert {:ok, %Sound{}} = Core.delete_sound(sound)
      assert_raise Ecto.NoResultsError, fn -> Core.get_sound!(sound.id) end
    end

    test "change_sound/1 returns a sound changeset" do
      sound = sound_fixture()
      assert %Ecto.Changeset{} = Core.change_sound(sound)
    end
  end
end
