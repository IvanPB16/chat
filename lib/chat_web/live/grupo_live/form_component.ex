defmodule ChatWeb.GrupoLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Grupos

  @impl true
  def update(%{grupo: grupo} = assigns, socket) do
    changeset = Grupos.change_grupo(grupo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"grupo" => grupo_params}, socket) do
    changeset =
      socket.assigns.grupo
      |> Grupos.change_grupo(grupo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"grupo" => grupo_params}, socket) do
    save_grupo(socket, socket.assigns.action, grupo_params)
  end

  defp save_grupo(socket, :edit, grupo_params) do
    case Grupos.update_grupo(socket.assigns.grupo, grupo_params) do
      {:ok, _grupo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Grupo updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_grupo(socket, :grupo, grupo_params) do
    case Grupos.create_grupo(grupo_params) do
      {:ok, grupo} ->
        user_grupo_params = %{
          "grupo_id" => grupo.id,
          "user_id" => grupo_params["user_id"]
        }
        Grupos.create_user_grupo(user_grupo_params)
        {:noreply,
         socket
         |> put_flash(:info, "Grupo created successfully")
         |> push_redirect(to: "/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
