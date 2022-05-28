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

  describe "grupos" do
    alias Chat.Grupos.Grupo

    import Chat.GruposFixtures

    @invalid_attrs %{name: nil, status: nil}

    test "list_grupos/0 returns all grupos" do
      grupo = grupo_fixture()
      assert Grupos.list_grupos() == [grupo]
    end

    test "get_grupo!/1 returns the grupo with given id" do
      grupo = grupo_fixture()
      assert Grupos.get_grupo!(grupo.id) == grupo
    end

    test "create_grupo/1 with valid data creates a grupo" do
      valid_attrs = %{name: "some name", status: "some status"}

      assert {:ok, %Grupo{} = grupo} = Grupos.create_grupo(valid_attrs)
      assert grupo.name == "some name"
      assert grupo.status == "some status"
    end

    test "create_grupo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grupos.create_grupo(@invalid_attrs)
    end

    test "update_grupo/2 with valid data updates the grupo" do
      grupo = grupo_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status"}

      assert {:ok, %Grupo{} = grupo} = Grupos.update_grupo(grupo, update_attrs)
      assert grupo.name == "some updated name"
      assert grupo.status == "some updated status"
    end

    test "update_grupo/2 with invalid data returns error changeset" do
      grupo = grupo_fixture()
      assert {:error, %Ecto.Changeset{}} = Grupos.update_grupo(grupo, @invalid_attrs)
      assert grupo == Grupos.get_grupo!(grupo.id)
    end

    test "delete_grupo/1 deletes the grupo" do
      grupo = grupo_fixture()
      assert {:ok, %Grupo{}} = Grupos.delete_grupo(grupo)
      assert_raise Ecto.NoResultsError, fn -> Grupos.get_grupo!(grupo.id) end
    end

    test "change_grupo/1 returns a grupo changeset" do
      grupo = grupo_fixture()
      assert %Ecto.Changeset{} = Grupos.change_grupo(grupo)
    end
  end
end
