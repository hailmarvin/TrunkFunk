defmodule TrunkFunk.Repo do
  use Ecto.Repo,
    otp_app: :trunk_funk,
    adapter: Ecto.Adapters.Postgres
end
