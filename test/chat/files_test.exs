defmodule Chat.FilesTest do
  use Chat.DataCase

  alias Chat.Files

  describe "files_group" do
    alias Chat.Files.FileGroup

    import Chat.FilesFixtures

    @invalid_attrs %{name: nil, path: nil}

    test "list_files_group/0 returns all files_group" do
      file_group = file_group_fixture()
      assert Files.list_files_group() == [file_group]
    end

    test "get_file_group!/1 returns the file_group with given id" do
      file_group = file_group_fixture()
      assert Files.get_file_group!(file_group.id) == file_group
    end

    test "create_file_group/1 with valid data creates a file_group" do
      valid_attrs = %{name: "some name", path: "some path"}

      assert {:ok, %FileGroup{} = file_group} = Files.create_file_group(valid_attrs)
      assert file_group.name == "some name"
      assert file_group.path == "some path"
    end

    test "create_file_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Files.create_file_group(@invalid_attrs)
    end

    test "update_file_group/2 with valid data updates the file_group" do
      file_group = file_group_fixture()
      update_attrs = %{name: "some updated name", path: "some updated path"}

      assert {:ok, %FileGroup{} = file_group} = Files.update_file_group(file_group, update_attrs)
      assert file_group.name == "some updated name"
      assert file_group.path == "some updated path"
    end

    test "update_file_group/2 with invalid data returns error changeset" do
      file_group = file_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Files.update_file_group(file_group, @invalid_attrs)
      assert file_group == Files.get_file_group!(file_group.id)
    end

    test "delete_file_group/1 deletes the file_group" do
      file_group = file_group_fixture()
      assert {:ok, %FileGroup{}} = Files.delete_file_group(file_group)
      assert_raise Ecto.NoResultsError, fn -> Files.get_file_group!(file_group.id) end
    end

    test "change_file_group/1 returns a file_group changeset" do
      file_group = file_group_fixture()
      assert %Ecto.Changeset{} = Files.change_file_group(file_group)
    end
  end
end
