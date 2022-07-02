defmodule Chat.Grupos.MessageGroups do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "grupos"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "message_groups" do

    field :from_to_id, :binary_id
    field :grupo_id, :binary_id
    field :message, :string
    field :status, :string, default: "SEND"

    timestamps()
  end

  @doc false
  def changeset(message_groups, attrs) do
    message_groups
    |> cast(attrs, [:from_to_id, :grupo_id, :message, :status])
    |> validate_required([:from_to_id, :grupo_id, :message])
  end
end
