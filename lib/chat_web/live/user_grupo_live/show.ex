defmodule ChatWeb.UserGrupoLive.Show do
  use ChatWeb, :live_view

  alias Chat.Grupos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_grupo, Grupos.get_user_grupo!(id))}
  end

  defp page_title(:show), do: "Show User grupo"
  defp page_title(:edit), do: "Edit User grupo"
end
