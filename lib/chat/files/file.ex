defmodule Chat.Files.File do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "files"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "files_conversations" do
    field :conversacion_id, :binary_id
    field :to_id, :binary_id
    field :from_to_id, :binary_id
    field :path, :string
    field :status, :string, default: "NEW"

    timestamps()
  end

  @doc false
  def changeset(file_group, attrs) do
    file_group
    |> cast(attrs, [:conversacion_id, :to_id, :from_to_id, :path, :status])
    |> validate_required([:conversacion_id, :to_id, :from_to_id, :path, :status])
  end
end
