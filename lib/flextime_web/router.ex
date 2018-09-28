defmodule FlextimeWeb.Router do
  use FlextimeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: FlextimeWeb.Schema,
            interface: :simple,
            context: %{pubsub: FlextimeWeb.Endpoint}
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlextimeWeb do
  #   pipe_through :api
  # end
end
