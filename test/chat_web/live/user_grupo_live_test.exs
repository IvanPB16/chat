defmodule ChatWeb.UserGrupoLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.GruposFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_user_grupo(_) do
    user_grupo = user_grupo_fixture()
    %{user_grupo: user_grupo}
  end

  describe "Index" do
    setup [:create_user_grupo]

    test "lists all user_grupo", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.user_grupo_index_path(conn, :index))

      assert html =~ "Listing User grupo"
    end

    test "saves new user_grupo", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_grupo_index_path(conn, :index))

      assert index_live |> element("a", "New User grupo") |> render_click() =~
               "New User grupo"

      assert_patch(index_live, Routes.user_grupo_index_path(conn, :new))

      assert index_live
             |> form("#user_grupo-form", user_grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_grupo-form", user_grupo: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_grupo_index_path(conn, :index))

      assert html =~ "User grupo created successfully"
    end

    test "updates user_grupo in listing", %{conn: conn, user_grupo: user_grupo} do
      {:ok, index_live, _html} = live(conn, Routes.user_grupo_index_path(conn, :index))

      assert index_live |> element("#user_grupo-#{user_grupo.id} a", "Edit") |> render_click() =~
               "Edit User grupo"

      assert_patch(index_live, Routes.user_grupo_index_path(conn, :edit, user_grupo))

      assert index_live
             |> form("#user_grupo-form", user_grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_grupo-form", user_grupo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_grupo_index_path(conn, :index))

      assert html =~ "User grupo updated successfully"
    end

    test "deletes user_grupo in listing", %{conn: conn, user_grupo: user_grupo} do
      {:ok, index_live, _html} = live(conn, Routes.user_grupo_index_path(conn, :index))

      assert index_live |> element("#user_grupo-#{user_grupo.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_grupo-#{user_grupo.id}")
    end
  end

  describe "Show" do
    setup [:create_user_grupo]

    test "displays user_grupo", %{conn: conn, user_grupo: user_grupo} do
      {:ok, _show_live, html} = live(conn, Routes.user_grupo_show_path(conn, :show, user_grupo))

      assert html =~ "Show User grupo"
    end

    test "updates user_grupo within modal", %{conn: conn, user_grupo: user_grupo} do
      {:ok, show_live, _html} = live(conn, Routes.user_grupo_show_path(conn, :show, user_grupo))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User grupo"

      assert_patch(show_live, Routes.user_grupo_show_path(conn, :edit, user_grupo))

      assert show_live
             |> form("#user_grupo-form", user_grupo: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user_grupo-form", user_grupo: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_grupo_show_path(conn, :show, user_grupo))

      assert html =~ "User grupo updated successfully"
    end
  end
end
