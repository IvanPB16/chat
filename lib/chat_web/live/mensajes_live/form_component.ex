defmodule ChatWeb.MensajesLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Conversaciones

  @impl true
  def update(%{mensajes: mensajes} = assigns, socket) do
    changeset = Conversaciones.change_mensajes(mensajes)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"mensajes" => mensajes_params}, socket) do
    changeset =
      socket.assigns.mensajes
      |> Conversaciones.change_mensajes(mensajes_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"mensajes" => mensajes_params}, socket) do
    save_mensajes(socket, socket.assigns.action, mensajes_params)
  end

  defp save_mensajes(socket, :edit, mensajes_params) do
    case Conversaciones.update_mensajes(socket.assigns.mensajes, mensajes_params) do
      {:ok, _mensajes} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mensajes updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_mensajes(socket, :new, mensajes_params) do
    case Conversaciones.create_mensajes(mensajes_params) do
      {:ok, _mensajes} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mensajes created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
