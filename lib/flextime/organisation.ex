defmodule Flextime.Organisation do
  use Ecto.Schema

  schema "organisation" do
    field :name, :string

    has_many :projects, Flextime.Customer
  end
end