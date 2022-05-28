defmodule Chat.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    schema = "grupos"

    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"
    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"
    create table(:roles, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false, default: "MEMBER"

      timestamps()
    end
    execute("ALTER TABLE #{schema}.roles ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.roles ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.roles ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
