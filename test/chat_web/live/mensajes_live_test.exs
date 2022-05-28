defmodule ChatWeb.MensajesLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.ConversacionesFixtures

  @create_attrs %{message: "some message", status: "some status"}
  @update_attrs %{message: "some updated message", status: "some updated status"}
  @invalid_attrs %{message: nil, status: nil}

  defp create_mensajes(_) do
    mensajes = mensajes_fixture()
    %{mensajes: mensajes}
  end

  describe "Index" do
    setup [:create_mensajes]

    test "lists all mensajes", %{conn: conn, mensajes: mensajes} do
      {:ok, _index_live, html} = live(conn, Routes.mensajes_index_path(conn, :index))

      assert html =~ "Listing Mensajes"
      assert html =~ mensajes.message
    end

    test "saves new mensajes", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mensajes_index_path(conn, :index))

      assert index_live |> element("a", "New Mensajes") |> render_click() =~
               "New Mensajes"

      assert_patch(index_live, Routes.mensajes_index_path(conn, :new))

      assert index_live
             |> form("#mensajes-form", mensajes: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mensajes-form", mensajes: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mensajes_index_path(conn, :index))

      assert html =~ "Mensajes created successfully"
      assert html =~ "some message"
    end

    test "updates mensajes in listing", %{conn: conn, mensajes: mensajes} do
      {:ok, index_live, _html} = live(conn, Routes.mensajes_index_path(conn, :index))

      assert index_live |> element("#mensajes-#{mensajes.id} a", "Edit") |> render_click() =~
               "Edit Mensajes"

      assert_patch(index_live, Routes.mensajes_index_path(conn, :edit, mensajes))

      assert index_live
             |> form("#mensajes-form", mensajes: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mensajes-form", mensajes: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mensajes_index_path(conn, :index))

      assert html =~ "Mensajes updated successfully"
      assert html =~ "some updated message"
    end

    test "deletes mensajes in listing", %{conn: conn, mensajes: mensajes} do
      {:ok, index_live, _html} = live(conn, Routes.mensajes_index_path(conn, :index))

      assert index_live |> element("#mensajes-#{mensajes.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mensajes-#{mensajes.id}")
    end
  end

  describe "Show" do
    setup [:create_mensajes]

    test "displays mensajes", %{conn: conn, mensajes: mensajes} do
      {:ok, _show_live, html} = live(conn, Routes.mensajes_show_path(conn, :show, mensajes))

      assert html =~ "Show Mensajes"
      assert html =~ mensajes.message
    end

    test "updates mensajes within modal", %{conn: conn, mensajes: mensajes} do
      {:ok, show_live, _html} = live(conn, Routes.mensajes_show_path(conn, :show, mensajes))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mensajes"

      assert_patch(show_live, Routes.mensajes_show_path(conn, :edit, mensajes))

      assert show_live
             |> form("#mensajes-form", mensajes: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mensajes-form", mensajes: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mensajes_show_path(conn, :show, mensajes))

      assert html =~ "Mensajes updated successfully"
      assert html =~ "some updated message"
    end
  end
end
