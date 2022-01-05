defmodule Teachbase.Repo do
  use Ecto.Repo,
    otp_app: :teachbase,
    adapter: Ecto.Adapters.Postgres
end
