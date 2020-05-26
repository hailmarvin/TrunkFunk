defmodule TrunkFunkWeb.SessionController do
    use TrunkFunkWeb, :controller

    alias TrunkFunk.Accounts

    def new(conn, _params) do
        render(conn, "new.html")
      end
    
    def create(conn, %{"user" => %{"email" => "", "password" => ""}}) do
        conn
        |> put_flash(:error, "Please fill in an Email address and password")   
        |> redirect(to: Routes.session_path(conn, :new))
    end

    def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
        case Accounts.authenticate_by_email_password(email, password) do
            {:ok, user} ->
            conn
                |> put_flash(:info, "Welcome Back!")
                |> put_session(:user_id, user.id)
                |> configure_session(renew: true)
                |> redirect(to: "/")
            {:error, :unauthorized} ->
            conn
                |> put_flash(:error, "Bad Email/password combination")  
                |> redirect(to: Routes.session_path(conn, :new))
            {:error, :not_found} ->
            conn
                |> put_flash(:error, "Account not found")
                |> redirect(to: Routes.session_path(conn, :new))  
        end
    end

    def delete(conn, _user_params) do
        conn
        |> configure_session(drop: true)
        |> put_flash(:success, "Successfully Signed Out!")
        |> redirect(to: "/")
    end
end