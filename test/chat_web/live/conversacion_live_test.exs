defmodule ChatWeb.ConversacionLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.ConversacionesFixtures

  @create_attrs %{from_to: "some from_to", status: "some status"}
  @update_attrs %{from_to: "some updated from_to", status: "some updated status"}
  @invalid_attrs %{from_to: nil, status: nil}

  defp create_conversacion(_) do
    conversacion = conversacion_fixture()
    %{conversacion: conversacion}
  end

  describe "Index" do
    setup [:create_conversacion]

    test "lists all conversaciones", %{conn: conn, conversacion: conversacion} do
      {:ok, _index_live, html} = live(conn, Routes.conversacion_index_path(conn, :index))

      assert html =~ "Listing Conversaciones"
      assert html =~ conversacion.from_to
    end

    test "saves new conversacion", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.conversacion_index_path(conn, :index))

      assert index_live |> element("a", "New Conversacion") |> render_click() =~
               "New Conversacion"

      assert_patch(index_live, Routes.conversacion_index_path(conn, :new))

      assert index_live
             |> form("#conversacion-form", conversacion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#conversacion-form", conversacion: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.conversacion_index_path(conn, :index))

      assert html =~ "Conversacion created successfully"
      assert html =~ "some from_to"
    end

    test "updates conversacion in listing", %{conn: conn, conversacion: conversacion} do
      {:ok, index_live, _html} = live(conn, Routes.conversacion_index_path(conn, :index))

      assert index_live |> element("#conversacion-#{conversacion.id} a", "Edit") |> render_click() =~
               "Edit Conversacion"

      assert_patch(index_live, Routes.conversacion_index_path(conn, :edit, conversacion))

      assert index_live
             |> form("#conversacion-form", conversacion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#conversacion-form", conversacion: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.conversacion_index_path(conn, :index))

      assert html =~ "Conversacion updated successfully"
      assert html =~ "some updated from_to"
    end

    test "deletes conversacion in listing", %{conn: conn, conversacion: conversacion} do
      {:ok, index_live, _html} = live(conn, Routes.conversacion_index_path(conn, :index))

      assert index_live |> element("#conversacion-#{conversacion.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#conversacion-#{conversacion.id}")
    end
  end

  describe "Show" do
    setup [:create_conversacion]

    test "displays conversacion", %{conn: conn, conversacion: conversacion} do
      {:ok, _show_live, html} = live(conn, Routes.conversacion_show_path(conn, :show, conversacion))

      assert html =~ "Show Conversacion"
      assert html =~ conversacion.from_to
    end

    test "updates conversacion within modal", %{conn: conn, conversacion: conversacion} do
      {:ok, show_live, _html} = live(conn, Routes.conversacion_show_path(conn, :show, conversacion))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Conversacion"

      assert_patch(show_live, Routes.conversacion_show_path(conn, :edit, conversacion))

      assert show_live
             |> form("#conversacion-form", conversacion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#conversacion-form", conversacion: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.conversacion_show_path(conn, :show, conversacion))

      assert html =~ "Conversacion updated successfully"
      assert html =~ "some updated from_to"
    end
  end
end
