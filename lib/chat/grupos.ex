defmodule Chat.Grupos do
  @moduledoc """
  The Grupos context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Grupos.Rol
  alias Chat.Grupos.Grupo
  alias Chat.Grupos.UserGrupo

  def lista_grupos_by_user_id(user_id) do
    query = from g in Grupo,
    join: ug in UserGrupo, on: g.id == ug.grupo_id,
      where: ug.user_id == ^user_id,
      select: %{
        id: g.id,
        username: g.name,
        from_to_id: "",
        status: g.status,
        email: g.name,
        update_at: fragment("to_char(?,'HH:MI')", g.updated_at),
        type: "GRUOP"
      }
    Repo.all(query) |> IO.inspect
  end

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

  @doc """
  Returns the list of grupos.

  ## Examples

      iex> list_grupos()
      [%Grupo{}, ...]

  """
  def list_grupos do
    Repo.all(Grupo)
  end

  @doc """
  Gets a single grupo.

  Raises `Ecto.NoResultsError` if the Grupo does not exist.

  ## Examples

      iex> get_grupo!(123)
      %Grupo{}

      iex> get_grupo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grupo!(id), do: Repo.get!(Grupo, id)
  def get_grupo_select!(id) do
    query = from g in Grupo,
      where: g.id == ^id,
      select: %{
        id: g.id,
        email: g.name,
        username: g.name
      }
    Repo.one!(query)
  end

  @doc """
  Creates a grupo.

  ## Examples

      iex> create_grupo(%{field: value})
      {:ok, %Grupo{}}

      iex> create_grupo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grupo(attrs \\ %{}) do
    %Grupo{}
    |> Grupo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a grupo.

  ## Examples

      iex> update_grupo(grupo, %{field: new_value})
      {:ok, %Grupo{}}

      iex> update_grupo(grupo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grupo(%Grupo{} = grupo, attrs) do
    grupo
    |> Grupo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a grupo.

  ## Examples

      iex> delete_grupo(grupo)
      {:ok, %Grupo{}}

      iex> delete_grupo(grupo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grupo(%Grupo{} = grupo) do
    Repo.delete(grupo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grupo changes.

  ## Examples

      iex> change_grupo(grupo)
      %Ecto.Changeset{data: %Grupo{}}

  """
  def change_grupo(%Grupo{} = grupo, attrs \\ %{}) do
    Grupo.changeset(grupo, attrs)
  end

  @doc """
  Returns the list of user_grupo.

  ## Examples

      iex> list_user_grupo()
      [%UserGrupo{}, ...]

  """
  def list_user_grupo do
    Repo.all(UserGrupo)
  end

  @doc """
  Gets a single user_grupo.

  Raises `Ecto.NoResultsError` if the User grupo does not exist.

  ## Examples

      iex> get_user_grupo!(123)
      %UserGrupo{}

      iex> get_user_grupo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_grupo!(id), do: Repo.get!(UserGrupo, id)

  @doc """
  Creates a user_grupo.

  ## Examples

      iex> create_user_grupo(%{field: value})
      {:ok, %UserGrupo{}}

      iex> create_user_grupo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_grupo(attrs \\ %{}) do
    %UserGrupo{}
    |> UserGrupo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_grupo.

  ## Examples

      iex> update_user_grupo(user_grupo, %{field: new_value})
      {:ok, %UserGrupo{}}

      iex> update_user_grupo(user_grupo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_grupo(%UserGrupo{} = user_grupo, attrs) do
    user_grupo
    |> UserGrupo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_grupo.

  ## Examples

      iex> delete_user_grupo(user_grupo)
      {:ok, %UserGrupo{}}

      iex> delete_user_grupo(user_grupo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_grupo(%UserGrupo{} = user_grupo) do
    Repo.delete(user_grupo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_grupo changes.

  ## Examples

      iex> change_user_grupo(user_grupo)
      %Ecto.Changeset{data: %UserGrupo{}}

  """
  def change_user_grupo(%UserGrupo{} = user_grupo, attrs \\ %{}) do
    UserGrupo.changeset(user_grupo, attrs)
  end
end
