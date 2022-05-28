defmodule Chat.GruposFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.Grupos` context.
  """

  @doc """
  Generate a rol.
  """
  def rol_fixture(attrs \\ %{}) do
    {:ok, rol} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Chat.Grupos.create_rol()

    rol
  end

  @doc """
  Generate a grupo.
  """
  def grupo_fixture(attrs \\ %{}) do
    {:ok, grupo} =
      attrs
      |> Enum.into(%{
        name: "some name",
        status: "some status"
      })
      |> Chat.Grupos.create_grupo()

    grupo
  end
end
