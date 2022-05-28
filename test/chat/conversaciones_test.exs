defmodule Chat.ConversacionesTest do
  use Chat.DataCase

  alias Chat.Conversaciones

  describe "conversaciones" do
    alias Chat.Conversaciones.Conversacion

    import Chat.ConversacionesFixtures

    @invalid_attrs %{from_to: nil, status: nil}

    test "list_conversaciones/0 returns all conversaciones" do
      conversacion = conversacion_fixture()
      assert Conversaciones.list_conversaciones() == [conversacion]
    end

    test "get_conversacion!/1 returns the conversacion with given id" do
      conversacion = conversacion_fixture()
      assert Conversaciones.get_conversacion!(conversacion.id) == conversacion
    end

    test "create_conversacion/1 with valid data creates a conversacion" do
      valid_attrs = %{from_to: "some from_to", status: "some status"}

      assert {:ok, %Conversacion{} = conversacion} = Conversaciones.create_conversacion(valid_attrs)
      assert conversacion.from_to == "some from_to"
      assert conversacion.status == "some status"
    end

    test "create_conversacion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conversaciones.create_conversacion(@invalid_attrs)
    end

    test "update_conversacion/2 with valid data updates the conversacion" do
      conversacion = conversacion_fixture()
      update_attrs = %{from_to: "some updated from_to", status: "some updated status"}

      assert {:ok, %Conversacion{} = conversacion} = Conversaciones.update_conversacion(conversacion, update_attrs)
      assert conversacion.from_to == "some updated from_to"
      assert conversacion.status == "some updated status"
    end

    test "update_conversacion/2 with invalid data returns error changeset" do
      conversacion = conversacion_fixture()
      assert {:error, %Ecto.Changeset{}} = Conversaciones.update_conversacion(conversacion, @invalid_attrs)
      assert conversacion == Conversaciones.get_conversacion!(conversacion.id)
    end

    test "delete_conversacion/1 deletes the conversacion" do
      conversacion = conversacion_fixture()
      assert {:ok, %Conversacion{}} = Conversaciones.delete_conversacion(conversacion)
      assert_raise Ecto.NoResultsError, fn -> Conversaciones.get_conversacion!(conversacion.id) end
    end

    test "change_conversacion/1 returns a conversacion changeset" do
      conversacion = conversacion_fixture()
      assert %Ecto.Changeset{} = Conversaciones.change_conversacion(conversacion)
    end
  end
end
