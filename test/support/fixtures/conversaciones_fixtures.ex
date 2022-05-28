defmodule Chat.ConversacionesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.Conversaciones` context.
  """

  @doc """
  Generate a unique conversacion from_to.
  """
  def unique_conversacion_from_to, do: "some from_to#{System.unique_integer([:positive])}"

  @doc """
  Generate a conversacion.
  """
  def conversacion_fixture(attrs \\ %{}) do
    {:ok, conversacion} =
      attrs
      |> Enum.into(%{
        from_to: unique_conversacion_from_to(),
        status: "some status"
      })
      |> Chat.Conversaciones.create_conversacion()

    conversacion
  end
end
