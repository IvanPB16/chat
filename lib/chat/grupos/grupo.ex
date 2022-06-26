defmodule Chat.Grupos.Grupo do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "grupos"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "grupos" do
    field :name, :string
    field :status, :string, default: "ACTIVE"

    timestamps()
  end

  @doc false
  def changeset(grupo, attrs) do
    grupo
    |> cast(attrs, [:name, :status])
    |> validate_required([:name])
  end
end
