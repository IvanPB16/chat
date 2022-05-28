defmodule Chat.Conversaciones do
  @moduledoc """
  The Conversaciones context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Conversaciones.Conversacion

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
end
