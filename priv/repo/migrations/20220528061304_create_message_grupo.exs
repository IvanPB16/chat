defmodule Chat.Repo.Migrations.CreateUserGrupo do
  use Ecto.Migration

  def change do
    schema = "grupos"

    create table(:message_groups, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :from_to_id, references(:users, prefix: :auth, on_delete: :delete_all, type: :binary_id)
      add :grupo_id, references(:grupos, prefix: :grupos, on_delete: :delete_all, type: :binary_id)
      add :message, :string
      add :status, :string, default: "NEW"

      timestamps()
    end

    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.user_grupo ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
