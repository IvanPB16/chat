defmodule ChatWeb.FileLive.Index do
  use ChatWeb, :live_view

  alias Chat.Files.File
  alias Chat.Conversaciones

  @impl true
  def mount(params, _session, socket) do
    value = Map.get(params, "conversacion_id")

    if value == "" do
      {:ok,
         socket
         |> push_redirect(to: "/")}
    else
      conversation = Conversaciones.get_conversacion!(value) |> IO.inspect()
      {:ok, assign(socket, conversacion_id: params["conversacion_id"], conversation: conversation)}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New File")
    |> assign(:file, %File{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Subir Archivo")
    |> assign(:file, %File{})
  end
end
