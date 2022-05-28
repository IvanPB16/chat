defmodule ChatWeb.ConversacionLive.Index do
  use ChatWeb, :live_view

  alias Chat.Conversaciones
  alias Chat.Conversaciones.Conversacion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :conversaciones, list_conversaciones())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Conversacion")
    |> assign(:conversacion, Conversaciones.get_conversacion!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Conversacion")
    |> assign(:conversacion, %Conversacion{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Conversaciones")
    |> assign(:conversacion, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    conversacion = Conversaciones.get_conversacion!(id)
    {:ok, _} = Conversaciones.delete_conversacion(conversacion)

    {:noreply, assign(socket, :conversaciones, list_conversaciones())}
  end

  defp list_conversaciones do
    Conversaciones.list_conversaciones()
  end
end
