defmodule ChatWeb.FileGroupLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Files

  @impl true
  def update(%{file_group: file_group} = assigns, socket) do
    changeset = Files.change_file_group(file_group)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"file_group" => file_group_params}, socket) do
    changeset =
      socket.assigns.file_group
      |> Files.change_file_group(file_group_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"file_group" => file_group_params}, socket) do
    save_file_group(socket, socket.assigns.action, file_group_params)
  end

  defp save_file_group(socket, :edit, file_group_params) do
    case Files.update_file_group(socket.assigns.file_group, file_group_params) do
      {:ok, _file_group} ->
        {:noreply,
         socket
         |> put_flash(:info, "File group updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_file_group(socket, :new, file_group_params) do
    case Files.create_file_group(file_group_params) do
      {:ok, _file_group} ->
        {:noreply,
         socket
         |> put_flash(:info, "File group created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
