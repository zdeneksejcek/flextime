defmodule Flextime.Customer do
  use Ecto.Schema

  schema "customer" do
    field :name, :string

    belongs_to :organisation, Flextime.Organisation
  end

end
