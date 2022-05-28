defmodule Chat.Conversaciones.Mensajes do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "conversacion"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "mensajes" do
    field :message, :string
    field :status, :string, default: "SEND"
    field :conversacion_id, :binary_id
    field :from_to_id, :binary_id
    field :to_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(mensajes, attrs) do
    mensajes
    |> cast(attrs, [:conversacion_id, :from_to_id, :to_id, :message, :status])
    |> validate_required([:conversacion_id, :from_to_id, :to_id, :message, :status])
  end
end
