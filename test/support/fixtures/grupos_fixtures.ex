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
end
