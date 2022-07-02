defmodule ChatWeb.ConversacionLive.Index do
  use ChatWeb, :live_view

  alias Chat.Accounts
  alias Chat.Grupos
  alias Chat.Conversaciones
  alias Chat.Conversaciones.Conversacion
  alias Chat.Grupos.Grupo

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    if connected?(socket) do
      Conversaciones.subscribe()
    end

    current_user = Accounts.get_user_by_session_token(user_token)
    if !is_nil(current_user) do
      {:ok, assign(socket,
        conversaciones: list_conversaciones(current_user.id),
        mensajes: [],
        user_id: current_user.id,
        information: Accounts.get_user_by_id(current_user.id),
        information_conversation: nil)}
    else
      {:ok,
         socket
         |> push_redirect(to: "/users/log_in")}
    end

  end

  @impl true
  def handle_info({:message_inserted, new_message},socket) do
    IO.inspect new_message, label: "new_message"
    {:noreply, assign(socket, mensajes: list_mensajes_conversation(new_message.conversacion_id), from_to: new_message.from_to_id, conversacion_id: new_message.conversacion_id)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :grupo, _params) do
    socket
    |> assign(:page_title, "Nuevo grupo")
    |> assign(:conversation, %Conversacion{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
    |> assign(:grupo, %Grupo{})
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Nueva Conversacion")
    |> assign(:conversation, %Conversacion{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Chat")
    |> assign(:mensajes, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)

  end

  @impl true
  def handle_event("select_conversation", %{ "conversation" => conversation, "fromtoid" => fromtoid, "type" => type}, socket) do
    IO.inspect type
    case type do
      "ONE" ->
        IO.inspect "here one"
        mensajes = list_mensajes_conversation(conversation)
        information = get_information_conversation(fromtoid)
        {:noreply, assign(socket, mensajes: mensajes, from_to: fromtoid, conversacion_id: conversation, information_conversation: information)}
      "GRUOP" ->
        IO.inspect "here group"
        information= get_information_group(conversation) |> IO.inspect
        {:noreply, assign(socket, mensajes: [], from_to: "", conversacion_id: "", information_conversation: information)}
    end
  end

  @impl true
  def handle_event("save", %{"form" => form}, socket) do
    case Conversaciones.create_mensajes(form) do
      {:ok, conversacion} ->
        IO.inspect(conversacion)
        IO.inspect list_mensajes_conversation(conversacion.id)
        {:noreply,
          socket
          |> assign(:mensajes, list_mensajes_conversation(form["conversacion_id"]))
          |> assign(:from_to, form["from_to_id"])
          |> assign(:conversacion_id, form["conversacion_id"])
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        {:noreply,
          socket
          |> assign(:mensajes, list_mensajes_conversation(form["conversacion_id"]))
          |> assign(:from_to, form["from_to_id"])
          |> assign(:conversacion_id, form["conversacion_id"])
        }
    end
  end

  defp list_conversaciones(id) do
    l1 = Conversaciones.list_conversaciones_session(id)
    l2 = list_conversaciones_grupos(id)
    l1 ++ l2
  end

  defp list_mensajes_conversation(id) do
    Conversaciones.list_mensajes_conversation(id)
  end

  defp get_information_conversation(id) do
    Accounts.get_user_by_id(id) |> IO.inspect
  end

  defp get_information_group(id) do
    Grupos.get_grupo_select!(id)
  end

  defp list_conversaciones_grupos(id) do
    Grupos.lista_grupos_by_user_id(id)
  end
end
