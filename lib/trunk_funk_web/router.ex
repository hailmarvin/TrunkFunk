defmodule TrunkFunkWeb.Router do
  use TrunkFunkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TrunkFunk.Auth, repo: TrunkFunk.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrunkFunkWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/albums", AlbumController
    resources "/merch", GoodController

    post "/login", SessionController, :create
    get "/login", SessionController, :new
    get "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrunkFunkWeb do
  #   pipe_through :api
  # end
end
