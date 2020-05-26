defmodule TrunkFunkWeb.PageController do
  use TrunkFunkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
