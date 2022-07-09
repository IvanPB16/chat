defmodule Chat.Files.FileGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "files"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "files_groups" do
    field :from_to_id, :binary_id
    field :grupo_id, :binary_id
    field :path, :string
    field :status, :string
    timestamps()
  end

  @doc false
  def changeset(file_group, attrs) do
    file_group
    |> cast(attrs, [:from_to_id, :grupo_id, :path, :status])
    |> validate_required([:from_to_id, :grupo_id, :path, :status])
  end
end
