defmodule Chat.Repo.Migrations.CreateUserGrupo do
  use Ecto.Migration

  def change do
    schema = "grupos"

    create table(:user_grupo, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id)
      add :grupo_id, references(:grupos, prefix: :grupos, on_delete: :delete_all, type: :binary_id)
      add :rol_id, references(:roles, prefix: :grupos, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create unique_index(:user_grupo, [:grupo_id, :user_id, :rol_id], prefix: schema)
    create index(:user_grupo, [:user_id], prefix: schema)
    create index(:user_grupo, [:grupo_id], prefix: schema)
    create index(:user_grupo, [:rol_id], prefix: schema)

    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
