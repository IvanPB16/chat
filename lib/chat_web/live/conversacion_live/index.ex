defmodule ChatWeb.ConversacionLive.Index do
  use ChatWeb, :live_view

  alias Chat.Accounts
  alias Chat.Grupos
  alias Chat.Conversaciones
  alias Chat.Conversaciones.Conversacion
  alias Chat.Grupos.{Grupo, UserGrupo}
  alias Chat.Files.{File, FileGroup}

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    if connected?(socket) do
      Conversaciones.subscribe()
      Grupos.subscribe()
    end

    current_user = Accounts.get_user_by_session_token(user_token)
    if !is_nil(current_user) do
      {:ok, assign(socket,
        conversaciones: list_conversaciones(current_user.id),
        mensajes: [],
        mensajesGrupo: [],
        user_id: current_user.id,
        information: Accounts.get_user_by_id(current_user.id),
        information_conversation: nil,
        type: "")}
    else
      {:ok,
         socket
         |> push_redirect(to: "/users/log_in")}
    end

  end

  @impl true
  def handle_info({:msg_group, message},socket) do
    IO.inspect socket, label: "socket.msg_group"
    IO.inspect message, label: "message"
    {:noreply, assign(socket, mensajesGrupo: list_message_group(message.grupo_id), from_to: message.from_to_id, conversacion_id: message.grupo_id)}
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
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
    |> assign(:file, %File{})
    |> assign(:file_group, %FileGroup{})
    |> assign(:grupo, %Grupo{})
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Nueva Conversacion")
    |> assign(:conversation, %Conversacion{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:grupo, %Grupo{})
    |> assign(:file, %File{})
    |> assign(:file_group, %FileGroup{})
    |> assign(:conversacion_id, nil)
  end

  defp apply_action(socket, :participante, _params) do
    socket
    |> assign(:page_title, "Nuevo Participante")
    |> assign(:conversation, %Conversacion{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
    |> assign(:grupo, %Grupo{})
    |> assign(:file, %File{})
    |> assign(:file_group, %FileGroup{})
    |> assign(:user_grupo, %UserGrupo{})
  end

  defp apply_action(socket, :file_conversation, _params) do
    socket
    |> assign(:page_title, "Nuevo archivo")
    |> assign(:conversation, %Conversacion{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
    |> assign(:grupo, %Grupo{})
    |> assign(:file, %File{})
    |> assign(:file_group, %FileGroup{})
    |> assign(:user_grupo, %UserGrupo{})
  end

  defp apply_action(socket, :file_group, _params) do
    socket
    |> assign(:page_title, "Nuevo archivo")
    |> assign(:conversation, %Conversacion{})
    |> assign(:file, %File{})
    |> assign(:file_group, %FileGroup{})
    |> assign(:from_to, nil)
    |> assign(:mensajes, [])
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)
    |> assign(:grupo, %Grupo{})
    |> assign(:user_grupo, %UserGrupo{})
  end
  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Chat")
    |> assign(:mensajes, [])
    |> assign(:mensajesGrupo, [])
    |> assign(:from_to, nil)
    |> assign(:conversacion, %Conversacion{})
    |> assign(:conversacion_id, nil)

  end

  @impl true
  def handle_event("select_conversation", %{ "conversation" => conversation, "fromtoid" => fromtoid, "type" => type}, socket) do
    case type do
      "ONE" ->
        mensajes = list_mensajes_conversation(conversation)
        information = get_information_conversation(fromtoid)
        {:noreply, assign(socket, mensajes: mensajes, from_to: fromtoid, conversacion_id: conversation, information_conversation: information, type: "")}
      "GRUOP" ->
        information= get_information_group(conversation) |> IO.inspect(label: "information_conversation")
        {:noreply, assign(socket, mensajesGrupo: list_message_group(conversation), from_to: "", conversacion_id: conversation, information_conversation: information, type: "group")}
    end
  end

  @impl true
  def handle_event("save", %{"form" => form}, socket) do
    type = Map.get(form, "type")
    create_message(socket, type, form)
  end

  defp list_conversaciones(id) do
    l1 = Conversaciones.list_conversaciones_session(id)
    l2 = list_conversaciones_grupos(id)
    l1 ++ l2
  end

  defp list_mensajes_conversation(id) do
    Conversaciones.list_mensajes_conversation(id)
  end

  defp list_message_group(id)  do
    Grupos.list_message_grupo(id)
  end

  defp get_information_conversation(id) do
    Accounts.get_user_by_id(id) |> Map.put(:type, "one")
  end

  defp get_information_group(id) do
    Grupos.get_grupo_select!(id) |> Map.put(:type, "group")
  end

  defp list_conversaciones_grupos(id) do
    Grupos.lista_grupos_by_user_id(id)
  end

  defp create_message(socket, type, form) when type == "group" do
    from_to = Map.get(form, "to_id")
    group_id = Map.get(form, "conversacion_id")
    new_map = Map.put(form, "from_to_id", from_to) |> Map.put("grupo_id", group_id)
    {:noreply, socket}
    case Grupos.create_message_grupo(new_map) do
      {:ok, _conversacion} ->
        {:noreply,
          socket
          |> assign(:mensajesGrupo, list_message_group(form["conversacion_id"]))
          |> assign(:from_to, form["to_id"])
          |> assign(:conversacion_id, form["conversacion_id"])
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        {:noreply,
          socket
          |> assign(:mensajesGrupo, list_message_group(form["conversacion_id"]))
          |> assign(:from_to, form["to_id"])
          |> assign(:conversacion_id, form["conversacion_id"])
        }
    end
  end

  defp create_message(socket, _type, form)do
    case Conversaciones.create_mensajes(form) do
      {:ok, _conversacion} ->
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

end
