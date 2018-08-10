# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :device_manager,
  ecto_repos: [DeviceManager.Repo]

# Configures the endpoint
config :device_manager, DeviceManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1e2x+GK1hhp5e/PU6BsmS74MfMG5oA9AhaOFzco3IGHhc9D2j4JXFQw6Zy2QhpcP",
  render_errors: [view: DeviceManagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DeviceManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]


config :auth_me, AuthMe.UserManager.Guardian,
  issuer: "auth_me",
  secret_key: "Vy55DPGHlDxDasJ4nCEy9XV1Q8DPiS47jRcFVSCz5BKu6wIudwRyxKNIo2v6DqsL" # put the result of the mix command above here

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"




