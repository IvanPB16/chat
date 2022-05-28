defmodule Chat.Grupos do
  @moduledoc """
  The Grupos context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Grupos.Rol

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Rol{}, ...]

  """
  def list_roles do
    Repo.all(Rol)
  end

  @doc """
  Gets a single rol.

  Raises `Ecto.NoResultsError` if the Rol does not exist.

  ## Examples

      iex> get_rol!(123)
      %Rol{}

      iex> get_rol!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rol!(id), do: Repo.get!(Rol, id)

  @doc """
  Creates a rol.

  ## Examples

      iex> create_rol(%{field: value})
      {:ok, %Rol{}}

      iex> create_rol(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rol(attrs \\ %{}) do
    %Rol{}
    |> Rol.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rol.

  ## Examples

      iex> update_rol(rol, %{field: new_value})
      {:ok, %Rol{}}

      iex> update_rol(rol, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rol(%Rol{} = rol, attrs) do
    rol
    |> Rol.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rol.

  ## Examples

      iex> delete_rol(rol)
      {:ok, %Rol{}}

      iex> delete_rol(rol)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rol(%Rol{} = rol) do
    Repo.delete(rol)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rol changes.

  ## Examples

      iex> change_rol(rol)
      %Ecto.Changeset{data: %Rol{}}

  """
  def change_rol(%Rol{} = rol, attrs \\ %{}) do
    Rol.changeset(rol, attrs)
  end
end
