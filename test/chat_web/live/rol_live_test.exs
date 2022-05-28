defmodule ChatWeb.RolLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.GruposFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_rol(_) do
    rol = rol_fixture()
    %{rol: rol}
  end

  describe "Index" do
    setup [:create_rol]

    test "lists all roles", %{conn: conn, rol: rol} do
      {:ok, _index_live, html} = live(conn, Routes.rol_index_path(conn, :index))

      assert html =~ "Listing Roles"
      assert html =~ rol.name
    end

    test "saves new rol", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rol_index_path(conn, :index))

      assert index_live |> element("a", "New Rol") |> render_click() =~
               "New Rol"

      assert_patch(index_live, Routes.rol_index_path(conn, :new))

      assert index_live
             |> form("#rol-form", rol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rol-form", rol: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rol_index_path(conn, :index))

      assert html =~ "Rol created successfully"
      assert html =~ "some name"
    end

    test "updates rol in listing", %{conn: conn, rol: rol} do
      {:ok, index_live, _html} = live(conn, Routes.rol_index_path(conn, :index))

      assert index_live |> element("#rol-#{rol.id} a", "Edit") |> render_click() =~
               "Edit Rol"

      assert_patch(index_live, Routes.rol_index_path(conn, :edit, rol))

      assert index_live
             |> form("#rol-form", rol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rol-form", rol: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rol_index_path(conn, :index))

      assert html =~ "Rol updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes rol in listing", %{conn: conn, rol: rol} do
      {:ok, index_live, _html} = live(conn, Routes.rol_index_path(conn, :index))

      assert index_live |> element("#rol-#{rol.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rol-#{rol.id}")
    end
  end

  describe "Show" do
    setup [:create_rol]

    test "displays rol", %{conn: conn, rol: rol} do
      {:ok, _show_live, html} = live(conn, Routes.rol_show_path(conn, :show, rol))

      assert html =~ "Show Rol"
      assert html =~ rol.name
    end

    test "updates rol within modal", %{conn: conn, rol: rol} do
      {:ok, show_live, _html} = live(conn, Routes.rol_show_path(conn, :show, rol))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rol"

      assert_patch(show_live, Routes.rol_show_path(conn, :edit, rol))

      assert show_live
             |> form("#rol-form", rol: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rol-form", rol: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rol_show_path(conn, :show, rol))

      assert html =~ "Rol updated successfully"
      assert html =~ "some updated name"
    end
  end
end
