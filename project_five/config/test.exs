import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :project_five, ProjectFive.Repo,
  username: "project_five",
  password: "project_five",
  hostname: "localhost",
  database: "project_five_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :project_five, ProjectFiveWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A13sIpDrvfIuDUrT3q/dHC2bEBjp+/0qZjgU3K7Z3CUJePPJTE0+10p5cn1FUDQW",
  server: false

# In test we don't send emails.
config :project_five, ProjectFive.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
