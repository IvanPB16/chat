defmodule ChatWeb.ConversacionLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Conversaciones
  alias Chat.Accounts

  @impl true
  def update(%{conversacion: conversacion} = assigns, socket) do
    changeset = Conversaciones.change_conversacion(conversacion)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"conversacion" => conversacion_params}, socket) do
    changeset =
      socket.assigns.conversacion
      |> Conversaciones.change_conversacion(conversacion_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"conversacion" => conversacion_params}, socket) do
    save_conversacion(socket, socket.assigns.action, conversacion_params)
  end

  defp save_conversacion(socket, :edit, conversacion_params) do
    case Conversaciones.update_conversacion(socket.assigns.conversacion, conversacion_params) do
      {:ok, _conversacion} ->
        {:noreply,
         socket
         |> put_flash(:info, "Conversacion updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_conversacion(socket, :new, conversacion_params) do
    email = Accounts.search_user_by_email(conversacion_params["mask"])
    if !is_nil(email) do
      newMap = Map.put(conversacion_params, "from_to_id", email.id) |> Map.put("mask", conversacion_params["from_to_id"])
      case Conversaciones.create_conversacion(newMap ) do
        {:ok, _conversacion} ->
          {:noreply,
           socket
           |> put_flash(:info, "Conversacion created successfully")
           |> push_redirect(to: socket.assigns.return_to)}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
      end
    else
      {:noreply,
           socket
           |> put_flash(:error, "Usuario no encontrado")
           |> push_redirect(to: "/conversaciones/new")}
    end
  end
end
