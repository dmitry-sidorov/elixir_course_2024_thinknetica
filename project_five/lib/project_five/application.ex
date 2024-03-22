defmodule ProjectFive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ProjectFiveWeb.Telemetry,
      # Start the Ecto repository
      ProjectFive.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ProjectFive.PubSub},
      # Start Finch
      {Finch, name: ProjectFive.Finch},
      # Start the Endpoint (http/https)
      ProjectFiveWeb.Endpoint
      # Start a worker by calling: ProjectFive.Worker.start_link(arg)
      # {ProjectFive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectFive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjectFiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
