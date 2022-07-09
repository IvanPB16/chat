defmodule ChatWeb.FileLive.FormComponent do
  use ChatWeb, :live_component

  alias Chat.Files
  alias Chat.Files.File, as: FileSchema

  @impl true
  def mount(socket) do
    {:ok,
      socket
      |> assign(:uploaded_files, [])
      |> allow_upload(:avatar, accept: ~w(.jpg .jpeg), max_entries: 1)}
  end

  @impl true
  def update(%{file: file} = assigns, socket) do
    changeset = Files.change_file(file)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :avatar, ref)}
  end

  @impl true
  def handle_event("save", _params, socket) do
    IO.inspect socket.assigns.conversation, label: "hola"
    picture = put_photo_url(socket, %FileSchema{})
    conversation = Map.merge(picture, socket.assigns.conversation)
    IO.inspect conversation, label: "conversation"
    IO.inspect socket.assigns.conversacion_id, label: "conversacion_id"
    conversation_with_id = Map.put(conversation, :conversacion_id, socket.assigns.conversacion_id)


    IO.inspect(conversation_with_id, label: "conversation_with_id")
    {_schema, map} = Map.pop!(conversation_with_id, :__meta__)
    {_schema, map} = Map.pop!(map, :__struct__)
    IO.inspect map, label: "map"
    ja = Map.merge(%FileSchema{}, map)
    IO.inspect ja

    case Files.create_file(ja, %{}, &consume_photo(socket, &1)) do
      {:ok, _picture} ->
        {:noreply,
         socket
         |> put_flash(:info, "Imagen agregada")
         |> push_redirect(to: "/files?conversacion_id=0dc7ac80-c0e6-43eb-ae91-50221421e213")}
        # {:noreply, socket}
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        {:noreply, socket}
    end

    # uploaded_files =
    #   consume_uploaded_entries(socket, :avatar, fn %{path: path}, entry ->
    #     dest = Path.join([:code.priv_dir(:chat), "static", "images", "#{entry.uuid}.#{ext(entry)}"])
    #     File.cp!(path, dest)
    #     {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
    #   end)

    # {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end


  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    ext
  end

  defp put_photo_url(socket, %FileSchema{} = files) do
    {completed, []} = uploaded_entries(socket, :avatar)

    urls =
      for entry <- completed do
        Routes.static_path(socket, "/images/#{entry.uuid}.#{ext(entry)}")
      end

    url = Enum.at(urls, 0)

    %FileSchema{files | path: url}
  end

  def consume_photo(socket, %FileSchema{} = files) do
    consume_uploaded_entries(socket, :avatar, fn meta, entry ->
      dest = Path.join([:code.priv_dir(:chat), "static", "images", "#{entry.uuid}.#{ext(entry)}"])
      File.cp!(meta.path, dest)
      {:ok, files}
    end)

    {:ok, files}
  end

  # def handle_event("save", %{"file" => file_params}, socket) do
  #   save_file(socket, socket.assigns.action, file_params)
  # end



  # defp save_file(socket, :new, file_params) do
  #   case Files.create_file(file_params) do
  #     {:ok, _file} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "File created successfully")
  #        |> push_redirect(to: socket.assigns.return_to)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #   end
  # end

  def error_to_string(:too_large), do: "Too large"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  def error_to_string(:too_many_files), do: "You have selected too many files"

end
