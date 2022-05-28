defmodule ChatWeb.RolLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Grupos

  @impl true
  def update(%{rol: rol} = assigns, socket) do
    changeset = Grupos.change_rol(rol)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"rol" => rol_params}, socket) do
    changeset =
      socket.assigns.rol
      |> Grupos.change_rol(rol_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"rol" => rol_params}, socket) do
    save_rol(socket, socket.assigns.action, rol_params)
  end

  defp save_rol(socket, :edit, rol_params) do
    case Grupos.update_rol(socket.assigns.rol, rol_params) do
      {:ok, _rol} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rol updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_rol(socket, :new, rol_params) do
    case Grupos.create_rol(rol_params) do
      {:ok, _rol} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rol created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
