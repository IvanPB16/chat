defmodule Chat.Repo.Migrations.CreateFilesConversation do
  use Ecto.Migration

  def change do
    schema = "files"

    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"

    create table(:files_conversations, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :conversacion_id, references(:conversaciones, prefix: :conversacion, on_delete: :delete_all, type: :binary_id)
      add :to_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false
      add :from_to_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false
      add :path, :text
      add :status, :string, default: "NEW"

      timestamps()
    end

    execute("ALTER TABLE #{schema}.files_conversations ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.files_conversations ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.files_conversations ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
