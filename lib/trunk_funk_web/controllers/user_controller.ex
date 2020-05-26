defmodule TrunkFunkWeb.UserController do
  use TrunkFunkWeb, :controller

  alias TrunkFunk.Accounts
  alias TrunkFunk.Accounts.User
  plug :logged_in_user when not action in [:new, :create]
  plug :correct_user when action in [:edit, :update, :delete]
  plug :authenticate_admin, [pokerface: true] when action in [:index]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn        
        |> TrunkFunk.Auth.login(user)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  defp correct_user(%{assigns: %{current_user: current, admin_user: admin}, 
                      params: %{"id" => id}} = conn, _params) do

    if String.to_integer(id) == current.id || admin do
      conn
    else
      conn
      |> put_flash(:error, "You do not have access to that page")
      |> redirect(to: Routes.user_path(conn, :show, current)) 
      |> halt() 
    end                  
  end
end
