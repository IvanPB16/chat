defmodule ChatWeb.FileGroupLive.Show do
  use ChatWeb, :live_view

  alias Chat.Files

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:file_group, Files.get_file_group!(id))}
  end

  defp page_title(:show), do: "Show File group"
  defp page_title(:edit), do: "Edit File group"
end
