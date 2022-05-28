defmodule ChatWeb.MensajesLive.Show do
  use ChatWeb, :live_view

  alias Chat.Conversaciones

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:mensajes, Conversaciones.get_mensajes!(id))}
  end

  defp page_title(:show), do: "Show Mensajes"
  defp page_title(:edit), do: "Edit Mensajes"
end
