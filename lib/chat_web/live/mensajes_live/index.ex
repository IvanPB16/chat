defmodule ChatWeb.MensajesLive.Index do
  use ChatWeb, :live_view

  alias Chat.Conversaciones
  alias Chat.Conversaciones.Mensajes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :mensajes_collection, list_mensajes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mensajes")
    |> assign(:mensajes, Conversaciones.get_mensajes!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mensajes")
    |> assign(:mensajes, %Mensajes{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mensajes")
    |> assign(:mensajes, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mensajes = Conversaciones.get_mensajes!(id)
    {:ok, _} = Conversaciones.delete_mensajes(mensajes)

    {:noreply, assign(socket, :mensajes_collection, list_mensajes())}
  end

  defp list_mensajes do
    Conversaciones.list_mensajes()
  end
end
