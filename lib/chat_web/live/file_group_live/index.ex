defmodule ChatWeb.FileGroupLive.Index do
  use ChatWeb, :live_view

  alias Chat.Files
  alias Chat.Files.FileGroup

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :files_group, list_files_group())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit File group")
    |> assign(:file_group, Files.get_file_group!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New File group")
    |> assign(:file_group, %FileGroup{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Files group")
    |> assign(:file_group, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    file_group = Files.get_file_group!(id)
    {:ok, _} = Files.delete_file_group(file_group)

    {:noreply, assign(socket, :files_group, list_files_group())}
  end

  defp list_files_group do
    Files.list_files_group()
  end
end
