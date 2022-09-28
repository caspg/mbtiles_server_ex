# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mbtiles_server_ex,
  ecto_repos: [MbtilesServerEx.Repo]

config :mbtiles_server_ex, MbtilesServerEx.Repo, database: "priv/poland-bicycle-infra.mbtiles"

# Configures the endpoint
config :mbtiles_server_ex, MbtilesServerExWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MbtilesServerExWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MbtilesServerEx.PubSub,
  live_view: [signing_salt: "jDE7lO0r"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
