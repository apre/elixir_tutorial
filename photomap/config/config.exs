# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :photomap, PhotomapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N2tpqzsrSjST+gp0VD1SPATQcATiPoemSXhkLcDg9unOcRQPhrSIa2km8cxr0cq4",
  render_errors: [view: PhotomapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Photomap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :phoenix, :format_encoders,
  json: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
