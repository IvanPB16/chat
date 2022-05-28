defmodule ChatWeb.GrupoLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.GruposFixtures

  @create_attrs %{name: "some name", status: "some status"}
  @update_attrs %{name: "some updated name", status: "some updated status"}
  @invalid_attrs %{name: nil, status: nil}

  defp create_grupo(_) do
    grupo = grupo_fixture()
    %{grupo: grupo}
  end

  describe "Index" do
    setup [:create_grupo]

    test "lists all grupos", %{conn: conn, grupo: grupo} do
      {:ok, _index_live, html} = live(conn, Routes.grupo_index_path(conn, :index))

      assert html =~ "Listing Grupos"
      assert html =~ grupo.name
    end

    test "saves new grupo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.grupo_index_path(conn, :index))

      assert index_live |> element("a", "New Grupo") |> render_click() =~
               "New Grupo"

      assert_patch(index_live, Routes.grupo_index_path(conn, :new))

      assert index_live
             |> form("#grupo-form", grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#grupo-form", grupo: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grupo_index_path(conn, :index))

      assert html =~ "Grupo created successfully"
      assert html =~ "some name"
    end

    test "updates grupo in listing", %{conn: conn, grupo: grupo} do
      {:ok, index_live, _html} = live(conn, Routes.grupo_index_path(conn, :index))

      assert index_live |> element("#grupo-#{grupo.id} a", "Edit") |> render_click() =~
               "Edit Grupo"

      assert_patch(index_live, Routes.grupo_index_path(conn, :edit, grupo))

      assert index_live
             |> form("#grupo-form", grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#grupo-form", grupo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grupo_index_path(conn, :index))

      assert html =~ "Grupo updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes grupo in listing", %{conn: conn, grupo: grupo} do
      {:ok, index_live, _html} = live(conn, Routes.grupo_index_path(conn, :index))

      assert index_live |> element("#grupo-#{grupo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#grupo-#{grupo.id}")
    end
  end

  describe "Show" do
    setup [:create_grupo]

    test "displays grupo", %{conn: conn, grupo: grupo} do
      {:ok, _show_live, html} = live(conn, Routes.grupo_show_path(conn, :show, grupo))

      assert html =~ "Show Grupo"
      assert html =~ grupo.name
    end

    test "updates grupo within modal", %{conn: conn, grupo: grupo} do
      {:ok, show_live, _html} = live(conn, Routes.grupo_show_path(conn, :show, grupo))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Grupo"

      assert_patch(show_live, Routes.grupo_show_path(conn, :edit, grupo))

      assert show_live
             |> form("#grupo-form", grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#grupo-form", grupo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.grupo_show_path(conn, :show, grupo))

      assert html =~ "Grupo updated successfully"
      assert html =~ "some updated name"
    end
  end
end
