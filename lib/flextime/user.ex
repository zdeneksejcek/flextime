defmodule Flextime.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Flextime.User

  schema "user" do
    field :name, :string
    field :email, :string
    field :hash, :string

    field :password, :string, virtual: true
  end

  @doc false
  def changeset(%Flextime.User{} = user, attrs) do
    user

    |> cast(attrs, [:email, :password, :name])
    |> validate_required([:email, :password, :name])
    |> unique_constraint(:email)

      # Hash passwords before saving them to the database.
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
