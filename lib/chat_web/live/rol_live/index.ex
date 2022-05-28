defmodule ChatWeb.RolLive.Index do
  use ChatWeb, :live_view

  alias Chat.Grupos
  alias Chat.Grupos.Rol

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :roles, list_roles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rol")
    |> assign(:rol, Grupos.get_rol!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rol")
    |> assign(:rol, %Rol{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Roles")
    |> assign(:rol, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rol = Grupos.get_rol!(id)
    {:ok, _} = Grupos.delete_rol(rol)

    {:noreply, assign(socket, :roles, list_roles())}
  end

  defp list_roles do
    Grupos.list_roles()
  end
end
