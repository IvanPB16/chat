defmodule Chat.Files do
  @moduledoc """
  The Files context.
  """

  import Ecto.Query, warn: false
  alias Chat.Repo

  alias Chat.Files.{File, FileGroup}

  @doc """
  Returns the list of files_group.

  ## Examples

      iex> list_files_group()
      [%FileGroup{}, ...]

  """
  def list_files_group do
    Repo.all(FileGroup)
  end

  @doc """
  Gets a single file_group.

  Raises `Ecto.NoResultsError` if the File group does not exist.

  ## Examples

      iex> get_file_group!(123)
      %FileGroup{}

      iex> get_file_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file_group!(id), do: Repo.get!(FileGroup, id)

  @doc """
  Creates a file_group.

  ## Examples

      iex> create_file_group(%{field: value})
      {:ok, %FileGroup{}}

      iex> create_file_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file_group(attrs \\ %{}) do
    %FileGroup{}
    |> FileGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file_group.

  ## Examples

      iex> update_file_group(file_group, %{field: new_value})
      {:ok, %FileGroup{}}

      iex> update_file_group(file_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file_group(%FileGroup{} = file_group, attrs) do
    file_group
    |> FileGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a file_group.

  ## Examples

      iex> delete_file_group(file_group)
      {:ok, %FileGroup{}}

      iex> delete_file_group(file_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file_group(%FileGroup{} = file_group) do
    Repo.delete(file_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file_group changes.

  ## Examples

      iex> change_file_group(file_group)
      %Ecto.Changeset{data: %FileGroup{}}

  """
  def change_file_group(%FileGroup{} = file_group, attrs \\ %{}) do
    FileGroup.changeset(file_group, attrs)
  end

  @doc """
  Creates a file_group.

  ## Examples

      iex> create_file_group(%{field: value})
      {:ok, %FileGroup{}}

      iex> create_file_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file(picture, attrs \\ %{}, after_save) do
    picture
    |> File.changeset(attrs)
    |> Repo.insert()
    |> after_save(after_save)
  end

  defp after_save({:ok, picture}, func) do
    {:ok, _picture} = func.(picture)
  end

  defp after_save(error, _func), do: error


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file_group changes.

  ## Examples

      iex> change_file(file)
      %Ecto.Changeset{data: %File{}}

  """
  def change_file(%File{} = file, attrs \\ %{}) do
    File.changeset(file, attrs)
  end
end
