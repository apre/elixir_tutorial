use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :device_manager, DeviceManagerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :device_manager, DeviceManager.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "devicemanager_test",
  password: "devicemanager_test",
  database: "devicemanager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
