defmodule TrunkFunk.Accounts.Credential do
    use Ecto.Schema
    import Ecto.Changeset
    alias TrunkFunk.Accounts.{User, Credential}
    alias Bcrypt
  
    schema "credentials" do
      field :email, :string
      field :password, :string, virtual: true
      field :password_confirmation, :string, virtual: true
      field :password_hash, :string

      belongs_to :user, User  
      timestamps()
    end
  
    @doc false
    def changeset(%Credential{} = credential, attrs) do
      credential
      |> cast(attrs, [:email])
      |> validate_required([:email])
      |> unique_constraint(:email)
    end
    
    def registration_changeset(struct, attrs \\ %{}) do
      struct
      |> changeset(attrs)
      |> cast(attrs, [:password, :password_confirmation])
      |> validate_required([:password, :password_confirmation])
      |> validate_length(:password, min: 8)
      |> validate_confirmation(:password)
      |> hash_password
    end

    defp hash_password(%{valid?: false} = changeset), do: changeset
    defp hash_password(%{valid?: true, changes: %{password: pass}} = changeset) do
      put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
    end
  end
  