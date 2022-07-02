defmodule Chat.Grupos.UserGrupo do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "grupos"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_grupo" do

    field :user_id, :binary_id
    field :grupo_id, :binary_id
    field :rol_id, :binary_id, default: "c2a78891-6a8a-4d54-ba94-5e84487f8c57"

    timestamps()
  end

  @doc false
  def changeset(user_grupo, attrs) do
    user_grupo
    |> cast(attrs, [:user_id, :grupo_id, :rol_id])
    |> validate_required([:user_id, :grupo_id])
    |> unique_constraint([:user_id, :grupo_id, :rol_id])
  end
end
