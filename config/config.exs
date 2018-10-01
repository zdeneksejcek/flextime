# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :flextime,
  ecto_repos: [Flextime.Repo]

# Configures the endpoint
config :flextime, FlextimeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2VsEFk/8zN8l03ysZ/ZEOvWsSzXznENZYhcwQ5agMbuHFzG7SCN8c3mUp4FuvQJW",
  render_errors: [view: FlextimeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Flextime.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# In config/config.exs, or config.prod.exs, etc.
config :flextime, Flextime.Emails.Mailer,
       adapter: Bamboo.SendGridAdapter,
       api_key: "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" # or {:system, "SENDGRID_API_KEY"}

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      nickname_field: :email,
      # param_nesting: "user",
      # uid_field: :email
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"