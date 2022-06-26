defmodule Chat.Accounts.UserSchema do
  use Ecto.Schema

  @schema_prefix "auth"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

end
