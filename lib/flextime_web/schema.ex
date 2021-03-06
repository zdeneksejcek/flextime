defmodule FlextimeWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  ## alias FlextimeWeb.LinkResolver

  @desc "Single organization entity, serves as container for various customers"
  object :organisation do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :customers, non_null(list_of(non_null(:customer)))
  end

  @desc "Single customer entity, serves as container for projects"
  object :customer do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :organisation, non_null(:organisation)
  end

  @desc "Project entity, represents amount of work"
  object :project do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :customer, non_null(:customer)
  end

  @desc "Record represents done work"
  object :record do
    field :id, non_null(:id)
    field :person, non_null(:person)
    field :from, :datetime
    field :to, :datetime
    field :timespan, :integer

    field :comment, :string
    field :project, :project
    field :customer, :customer
  end

  @desc "Person"
  object :person do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  @desc "User"
  object :user do
    field :email, non_null(:string)
  end

  @desc "Password reset result"
  object :reset do
    field :result, non_null(:result)
  end

  enum :result do
    value :ok, as: "ok"
    value :error, as: "error"
  end

  query do
    field :all_orgs, non_null(list_of(non_null(:organisation))) do
      resolve fn _, _ ->
        {:ok, Flextime.Organisation |> Flextime.Repo.all}
      end
    end

    field :records, non_null(list_of(non_null(:record)))
  end

  mutation do
    @desc "Register new user"
    field :register, type: :user do
      arg :email, non_null(:string)
      arg :word, non_null(:string)

      resolve &FlextimeWeb.Resolvers.Users.create_user/3
    end

    @desc "Reword existing user"
    field :reword, type: :reset do
      arg :email, non_null(:string)

      resolve &FlextimeWeb.Resolvers.Users.password_reset/3
    end
    
  end

end
