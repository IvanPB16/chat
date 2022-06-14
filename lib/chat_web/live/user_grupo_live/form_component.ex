defmodule ChatWeb.UserGrupoLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Grupos

  @impl true
  def update(%{user_grupo: user_grupo} = assigns, socket) do
    changeset = Grupos.change_user_grupo(user_grupo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_grupo" => user_grupo_params}, socket) do
    changeset =
      socket.assigns.user_grupo
      |> Grupos.change_user_grupo(user_grupo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user_grupo" => user_grupo_params}, socket) do
    save_user_grupo(socket, socket.assigns.action, user_grupo_params)
  end

  defp save_user_grupo(socket, :edit, user_grupo_params) do
    case Grupos.update_user_grupo(socket.assigns.user_grupo, user_grupo_params) do
      {:ok, _user_grupo} ->
        {:noreply,
         socket
         |> put_flash(:info, "User grupo updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user_grupo(socket, :new, user_grupo_params) do
    case Grupos.create_user_grupo(user_grupo_params) do
      {:ok, _user_grupo} ->
        {:noreply,
         socket
         |> put_flash(:info, "User grupo created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
