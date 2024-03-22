defmodule ProjectFive.Repo do
  use Ecto.Repo,
    otp_app: :project_five,
    adapter: Ecto.Adapters.Postgres
end
