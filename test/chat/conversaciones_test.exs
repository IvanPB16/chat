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

  describe "mensajes" do
    alias Chat.Conversaciones.Mensajes

    import Chat.ConversacionesFixtures

    @invalid_attrs %{message: nil, status: nil}

    test "list_mensajes/0 returns all mensajes" do
      mensajes = mensajes_fixture()
      assert Conversaciones.list_mensajes() == [mensajes]
    end

    test "get_mensajes!/1 returns the mensajes with given id" do
      mensajes = mensajes_fixture()
      assert Conversaciones.get_mensajes!(mensajes.id) == mensajes
    end

    test "create_mensajes/1 with valid data creates a mensajes" do
      valid_attrs = %{message: "some message", status: "some status"}

      assert {:ok, %Mensajes{} = mensajes} = Conversaciones.create_mensajes(valid_attrs)
      assert mensajes.message == "some message"
      assert mensajes.status == "some status"
    end

    test "create_mensajes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conversaciones.create_mensajes(@invalid_attrs)
    end

    test "update_mensajes/2 with valid data updates the mensajes" do
      mensajes = mensajes_fixture()
      update_attrs = %{message: "some updated message", status: "some updated status"}

      assert {:ok, %Mensajes{} = mensajes} = Conversaciones.update_mensajes(mensajes, update_attrs)
      assert mensajes.message == "some updated message"
      assert mensajes.status == "some updated status"
    end

    test "update_mensajes/2 with invalid data returns error changeset" do
      mensajes = mensajes_fixture()
      assert {:error, %Ecto.Changeset{}} = Conversaciones.update_mensajes(mensajes, @invalid_attrs)
      assert mensajes == Conversaciones.get_mensajes!(mensajes.id)
    end

    test "delete_mensajes/1 deletes the mensajes" do
      mensajes = mensajes_fixture()
      assert {:ok, %Mensajes{}} = Conversaciones.delete_mensajes(mensajes)
      assert_raise Ecto.NoResultsError, fn -> Conversaciones.get_mensajes!(mensajes.id) end
    end

    test "change_mensajes/1 returns a mensajes changeset" do
      mensajes = mensajes_fixture()
      assert %Ecto.Changeset{} = Conversaciones.change_mensajes(mensajes)
    end
  end
end
