defmodule TrunkFunk.Auth do    
    import Plug.Conn
    import Phoenix.Controller
    alias TrunkFunkWeb.Router.Helpers
    alias TrunkFunkWeb.ErrorView

    def init(opts) do
        Keyword.fetch!(opts, :repo)
    end
    
    def call(conn, _) do
        user_id = get_session(conn, :user_id)
        cond do
            user = conn.assigns[:current_user] ->
                conn
            user = user_id && TrunkFunk.Accounts.get_user!(user_id) ->
                put_current_user(conn, user)
            true ->
                put_current_user(conn, nil)  
        end
    end  
    
    def authenticate_admin(conn = %{assigns: %{admin_user: true}}, _), do: conn
    
    def authenticate_admin(conn, opts) do
        if opts[:pokerface] do
            conn
            |> put_status(404)
            |> render(ErrorView, :"404", message: "Page Not Found", layout: false)
            |> halt
        else
            conn
            |> put_flash(:error, "You do not have access to that Page")
            |> redirect(to: Helpers.page_path(conn, :index))
            |> halt
        end
    end

    def login(conn, user) do
        conn
        |> put_current_user(user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end

    def logged_in_user(conn = %{assigns: %{current_user: %{}}}, _), do: conn

    def logged_in_user(conn, _) do
        conn
        |> put_flash(:error, "You must be logged in to access that Page!")
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt
    end

    def logout(conn) do
        conn
        |> configure_session(drop: true)
    end

    defp put_current_user(conn, user) do
        conn
        |> assign(:current_user, user)
        |> assign(:admin_user, !!user && !!user.credential && 
            (user.credential.email == "Insert Admin email Here"))
    end
end