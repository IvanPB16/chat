defmodule Chat.Conversaciones do
  @moduledoc """
  The Conversaciones context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Conversaciones.Conversacion
  alias Chat.Accounts.User
  alias Chat.Conversaciones.Mensajes


  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Chat.PubSub, @topic)
  end

  def broadcast({:ok, record}, event) do
    Phoenix.PubSub.broadcast(Chat.PubSub, @topic, {event, record})
    {:ok, record}
  end

  def broadcast({:error, _} = error, _event), do: error

  @doc """
  Returns the list of conversaciones.

  ## Examples

      iex> list_conversaciones()
      [%Conversacion{}, ...]

  """
  def list_conversaciones do
    Repo.all(Conversacion)
  end

   @doc """
  Returns the list of conversaciones by session.

  ## Examples

      iex> list_conversaciones_session()
      [%Conversacion{}, ...]

  """
  def list_conversaciones_session(user_id) do
    l1 = get_conversation_to(user_id)
    l2 = get_conversation_from(user_id)

    l1 ++ l2
  end

  defp get_conversation_to(id) do
    query = from c in Conversacion,
      join: u in User, on: c.from_to_id == u.id,
      where: c.to_id == ^id,
      select: %{
        id: c.id,
        from_to_id: c.from_to_id,
        status: c.status,
        username: u.username,
        email: u.email,
        update_at: fragment("to_char(?,'HH:MI')", c.updated_at),
        type: "ONE"
      }
    Repo.all(query)
  end
  defp get_conversation_from(id) do
    query = from c in Conversacion,
      join: u in User, on: c.to_id == u.id,
      where: c.from_to_id == ^id,
      select: %{
        id: c.id,
        from_to_id: c.to_id,
        status: c.status,
        username: u.username,
        email: u.email,
        update_at: fragment("to_char(?,'HH:MI')", c.updated_at),
        type: "ONE"
      }
    Repo.all(query)
  end

  @doc """
  Gets a single conversacion.

  Raises `Ecto.NoResultsError` if the Conversacion does not exist.

  ## Examples

      iex> get_conversacion!(123)
      %Conversacion{}

      iex> get_conversacion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conversacion!(id), do: Repo.get!(Conversacion, id)

  @doc """
  Creates a conversacion.

  ## Examples

      iex> create_conversacion(%{field: value})
      {:ok, %Conversacion{}}

      iex> create_conversacion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conversacion(attrs \\ %{}) do
    %Conversacion{}
    |> Conversacion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversacion.

  ## Examples

      iex> update_conversacion(conversacion, %{field: new_value})
      {:ok, %Conversacion{}}

      iex> update_conversacion(conversacion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conversacion(%Conversacion{} = conversacion, attrs) do
    conversacion
    |> Conversacion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a conversacion.

  ## Examples

      iex> delete_conversacion(conversacion)
      {:ok, %Conversacion{}}

      iex> delete_conversacion(conversacion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conversacion(%Conversacion{} = conversacion) do
    Repo.delete(conversacion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversacion changes.

  ## Examples

      iex> change_conversacion(conversacion)
      %Ecto.Changeset{data: %Conversacion{}}

  """
  def change_conversacion(%Conversacion{} = conversacion, attrs \\ %{}) do
    Conversacion.changeset(conversacion, attrs)
  end

  @doc """
  Returns the list of mensajes.

  ## Examples

      iex> list_mensajes()
      [%Mensajes{}, ...]

  """
  def list_mensajes do
    Repo.all(Mensajes)
  end

  @doc """
  Returns the list of mensajes by conversacion.

  ## Examples

      iex> list_mensajes()
      [%Mensajes{}, ...]

  """
  def list_mensajes_conversation(id) do
    query = from m in Mensajes, where: m.conversacion_id == ^id,
    select: %{
      id: m.id,
      message: m.message,
      status: m.status,
      conversacion_id: m.conversacion_id,
      from_to_id: m.from_to_id,
      to_id: m.to_id,
      inserted_at: fragment("to_char(?,'HH:MI')", m.inserted_at),
      type: "ONE"
    }

    Repo.all(query)
  end

  @doc """
  Returns the list of mensajes.

  ## Examples

      iex> list_mensajes()
      [%Mensajes{}, ...]

  """
  def list_mensajes do
    Repo.all(Mensajes)
  end

  @doc """
  Gets a single mensajes.

  Raises `Ecto.NoResultsError` if the Mensajes does not exist.

  ## Examples

      iex> get_mensajes!(123)
      %Mensajes{}

      iex> get_mensajes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mensajes!(id), do: Repo.get!(Mensajes, id)

  @doc """
  Creates a mensajes.

  ## Examples

      iex> create_mensajes(%{field: value})
      {:ok, %Mensajes{}}

      iex> create_mensajes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mensajes(attrs \\ %{}) do
    %Mensajes{}
    |> Mensajes.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:message_inserted)
  end

  @doc """
  Updates a mensajes.

  ## Examples

      iex> update_mensajes(mensajes, %{field: new_value})
      {:ok, %Mensajes{}}

      iex> update_mensajes(mensajes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mensajes(%Mensajes{} = mensajes, attrs) do
    mensajes
    |> Mensajes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mensajes.

  ## Examples

      iex> delete_mensajes(mensajes)
      {:ok, %Mensajes{}}

      iex> delete_mensajes(mensajes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mensajes(%Mensajes{} = mensajes) do
    Repo.delete(mensajes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mensajes changes.

  ## Examples

      iex> change_mensajes(mensajes)
      %Ecto.Changeset{data: %Mensajes{}}

  """
  def change_mensajes(%Mensajes{} = mensajes, attrs \\ %{}) do
    Mensajes.changeset(mensajes, attrs)
  end
end
