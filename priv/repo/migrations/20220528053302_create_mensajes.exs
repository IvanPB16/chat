defmodule Chat.Repo.Migrations.CreateMensajes do
  use Ecto.Migration

  def change do
    schema = "conversacion"
    create table(:mensajes, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :message, :string
      add :status, :string
      add :conversacion_id, references(:conversaciones, prefix: schema, on_delete: :delete_all, type: :binary_id)
      add :to_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false
      add :from_to_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:mensajes, [:conversacion_id], prefix: schema)
    create index(:mensajes, [:from_to_id], prefix: schema)
    create index(:mensajes, [:to_id], prefix: schema)
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.conversaciones ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
