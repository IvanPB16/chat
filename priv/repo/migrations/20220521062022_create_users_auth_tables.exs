defmodule Chat.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    schema = "auth"

    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"
    create table(:users, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :username, :citext, null: true
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      timestamps()
    end

    create unique_index(:users, [:email], prefix: schema)

    execute("ALTER TABLE #{schema}.users ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.users ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.users ALTER COLUMN updated_at SET DEFAULT now();","")

    create table(:users_tokens, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, prefix: schema, type: :binary_id, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id], prefix: schema)
    create unique_index(:users_tokens, [:context, :token], prefix: schema)

    execute("ALTER TABLE #{schema}.users_tokens ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.users_tokens ALTER COLUMN inserted_at SET DEFAULT now();","")
  end
end
