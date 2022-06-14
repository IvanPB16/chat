defmodule ChatWeb.UserGrupoLive.Index do
  use ChatWeb, :live_view

  alias Chat.Grupos
  alias Chat.Grupos.UserGrupo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_grupo_collection, list_user_grupo())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User grupo")
    |> assign(:user_grupo, Grupos.get_user_grupo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User grupo")
    |> assign(:user_grupo, %UserGrupo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User grupo")
    |> assign(:user_grupo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_grupo = Grupos.get_user_grupo!(id)
    {:ok, _} = Grupos.delete_user_grupo(user_grupo)

    {:noreply, assign(socket, :user_grupo_collection, list_user_grupo())}
  end

  defp list_user_grupo do
    Grupos.list_user_grupo()
  end
end
