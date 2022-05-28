defmodule ChatWeb.GrupoLive.Index do
  use ChatWeb, :live_view

  alias Chat.Grupos
  alias Chat.Grupos.Grupo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :grupos, list_grupos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Grupo")
    |> assign(:grupo, Grupos.get_grupo!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Grupo")
    |> assign(:grupo, %Grupo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Grupos")
    |> assign(:grupo, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    grupo = Grupos.get_grupo!(id)
    {:ok, _} = Grupos.delete_grupo(grupo)

    {:noreply, assign(socket, :grupos, list_grupos())}
  end

  defp list_grupos do
    Grupos.list_grupos()
  end
end
