defmodule Chat.FilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chat.Files` context.
  """

  @doc """
  Generate a file_group.
  """
  def file_group_fixture(attrs \\ %{}) do
    {:ok, file_group} =
      attrs
      |> Enum.into(%{
        name: "some name",
        path: "some path"
      })
      |> Chat.Files.create_file_group()

    file_group
  end
end
