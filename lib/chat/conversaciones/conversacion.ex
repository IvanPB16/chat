defmodule Chat.Conversaciones.Conversacion do
  use Ecto.Schema
  import Ecto.Changeset


  @schema_prefix "conversacion"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "conversaciones" do
    field :status, :string, default: "ACTIVE"
    field :to_id, :binary_id
    field :from_to_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(conversacion, attrs) do
    conversacion
    |> cast(attrs, [:status, :from_to_id, :to_id])
    |> validate_required([:from_to_id, :to_id])
    |> unique_constraint([:from_to_id, :to_id])
  end
end
