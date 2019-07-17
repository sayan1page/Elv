# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :article_api,
  ecto_repos: [ArticleApi.Repo]

# Configures the endpoint
config :article_api, ArticleApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q0XMSpgncW8pA8uwrOKu1USZ9IqRVcJYr3EJk2A1kdHtW8+6RKFffAMyhtbHLYTp",
  render_errors: [view: ArticleApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ArticleApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
