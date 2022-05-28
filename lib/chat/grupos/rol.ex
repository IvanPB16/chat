defmodule Chat.Grupos.Rol do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "grupos"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "roles" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(rol, attrs) do
    rol
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
