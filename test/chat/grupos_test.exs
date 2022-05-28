defmodule Chat.GruposTest do
  use Chat.DataCase

  alias Chat.Grupos

  describe "roles" do
    alias Chat.Grupos.Rol

    import Chat.GruposFixtures

    @invalid_attrs %{name: nil}

    test "list_roles/0 returns all roles" do
      rol = rol_fixture()
      assert Grupos.list_roles() == [rol]
    end

    test "get_rol!/1 returns the rol with given id" do
      rol = rol_fixture()
      assert Grupos.get_rol!(rol.id) == rol
    end

    test "create_rol/1 with valid data creates a rol" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Rol{} = rol} = Grupos.create_rol(valid_attrs)
      assert rol.name == "some name"
    end

    test "create_rol/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grupos.create_rol(@invalid_attrs)
    end

    test "update_rol/2 with valid data updates the rol" do
      rol = rol_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Rol{} = rol} = Grupos.update_rol(rol, update_attrs)
      assert rol.name == "some updated name"
    end

    test "update_rol/2 with invalid data returns error changeset" do
      rol = rol_fixture()
      assert {:error, %Ecto.Changeset{}} = Grupos.update_rol(rol, @invalid_attrs)
      assert rol == Grupos.get_rol!(rol.id)
    end

    test "delete_rol/1 deletes the rol" do
      rol = rol_fixture()
      assert {:ok, %Rol{}} = Grupos.delete_rol(rol)
      assert_raise Ecto.NoResultsError, fn -> Grupos.get_rol!(rol.id) end
    end

    test "change_rol/1 returns a rol changeset" do
      rol = rol_fixture()
      assert %Ecto.Changeset{} = Grupos.change_rol(rol)
    end
  end
end
