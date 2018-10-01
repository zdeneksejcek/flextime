defmodule Flextime.Users do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Flextime.Repo

  alias Flextime.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_email_and_password(nil, password), do: {:error, :invalid}
  def get_user_by_email_and_password(email, nil), do: {:error, :invalid}

  def get_user_by_email_and_password(email, password) do
    with  %User{} = user <- Repo.get_by(User, email: String.downcase(email)),
          true <- Comeonin.Bcrypt.checkpw(password, user.hash) do
      {:ok, user}
    else
      _ ->
        # Help to mitigate timing attacks
        Comeonin.Bcrypt.dummy_checkpw
        {:error, :unauthorised}
    end
  end


end
