defmodule Chat.Repo.Migrations.CreateGrupos do
  use Ecto.Migration

  def change do
    schema = "grupos"

    create table(:grupos, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :status, :string, default: "NEW"

      timestamps()
    end
    execute("ALTER TABLE #{schema}.grupos ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.grupos ALTER COLUMN inserted_at SET DEFAULT now();","")
    execute("ALTER TABLE #{schema}.grupos ALTER COLUMN updated_at SET DEFAULT now();","")
  end
end
