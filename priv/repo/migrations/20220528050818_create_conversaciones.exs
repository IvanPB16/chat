defmodule Chat.Repo.Migrations.CreateConversaciones do
  use Ecto.Migration

  def change do
    schema = "conversacion"

    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"
    create table(:conversaciones, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :status, :string, default: "ACTIVE"
      add :to, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false
      add :from_to, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:conversaciones, [:from_to, :to], prefix: schema)
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
