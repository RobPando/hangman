# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :phx_client, PhxClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4VmFvVjZb1+gIw3k8XmaRHmLLP80jG+HQQWbGq8c5w/0lCwivoXy2v6B/qxG9zfP",
  render_errors: [view: PhxClientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxClient.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
