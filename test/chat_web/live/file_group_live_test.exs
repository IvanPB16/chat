defmodule ChatWeb.FileGroupLiveTest do
  use ChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import Chat.FilesFixtures

  @create_attrs %{name: "some name", path: "some path"}
  @update_attrs %{name: "some updated name", path: "some updated path"}
  @invalid_attrs %{name: nil, path: nil}

  defp create_file_group(_) do
    file_group = file_group_fixture()
    %{file_group: file_group}
  end

  describe "Index" do
    setup [:create_file_group]

    test "lists all files_group", %{conn: conn, file_group: file_group} do
      {:ok, _index_live, html} = live(conn, Routes.file_group_index_path(conn, :index))

      assert html =~ "Listing Files group"
      assert html =~ file_group.name
    end

    test "saves new file_group", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.file_group_index_path(conn, :index))

      assert index_live |> element("a", "New File group") |> render_click() =~
               "New File group"

      assert_patch(index_live, Routes.file_group_index_path(conn, :new))

      assert index_live
             |> form("#file_group-form", file_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#file_group-form", file_group: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.file_group_index_path(conn, :index))

      assert html =~ "File group created successfully"
      assert html =~ "some name"
    end

    test "updates file_group in listing", %{conn: conn, file_group: file_group} do
      {:ok, index_live, _html} = live(conn, Routes.file_group_index_path(conn, :index))

      assert index_live |> element("#file_group-#{file_group.id} a", "Edit") |> render_click() =~
               "Edit File group"

      assert_patch(index_live, Routes.file_group_index_path(conn, :edit, file_group))

      assert index_live
             |> form("#file_group-form", file_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#file_group-form", file_group: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.file_group_index_path(conn, :index))

      assert html =~ "File group updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes file_group in listing", %{conn: conn, file_group: file_group} do
      {:ok, index_live, _html} = live(conn, Routes.file_group_index_path(conn, :index))

      assert index_live |> element("#file_group-#{file_group.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#file_group-#{file_group.id}")
    end
  end

  describe "Show" do
    setup [:create_file_group]

    test "displays file_group", %{conn: conn, file_group: file_group} do
      {:ok, _show_live, html} = live(conn, Routes.file_group_show_path(conn, :show, file_group))

      assert html =~ "Show File group"
      assert html =~ file_group.name
    end

    test "updates file_group within modal", %{conn: conn, file_group: file_group} do
      {:ok, show_live, _html} = live(conn, Routes.file_group_show_path(conn, :show, file_group))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit File group"

      assert_patch(show_live, Routes.file_group_show_path(conn, :edit, file_group))

      assert show_live
             |> form("#file_group-form", file_group: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#file_group-form", file_group: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.file_group_show_path(conn, :show, file_group))

      assert html =~ "File group updated successfully"
      assert html =~ "some updated name"
    end
  end
end
