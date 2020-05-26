defmodule TrunkFunk.Accounts do

  import Ecto.Query, warn: false
  alias TrunkFunk.Repo

  alias TrunkFunk.Accounts.User
  alias TrunkFunk.Accounts.Credential
  import Bcrypt, only: [verify_pass: 2,no_user_verify: 0]

  def list_users do
    Repo.all(User) 
    |> Repo.preload(:credential)
  end

  def get_user!(id), do: Repo.get(User, id) 
    |> Repo.preload([:credential])
    
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with:
        &Credential.registration_changeset/2)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    cred_changeset = if attrs["credential"]["password"] == "" do
      &Credential.changeset/2
    else
      &Credential.registration_changeset/2
    end    

    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: cred_changeset)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def authenticate_by_email_password(email, given_pass) do
    cred = Repo.get_by(Credential, email: email) |> Repo.preload(:user)
    cond do
      cred && verify_pass(given_pass, cred.password_hash) ->
        {:ok, cred.user}
      cred -> 
        {:error, :unauthorized}  
      true ->
        no_user_verify()
        {:error, :not_found}  
    end
  end

  def list_credentials do
    Repo.all(Credential)
  end

  def get_credential!(id), do: Repo.get!(Credential, id)

  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end
end
