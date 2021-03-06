defmodule PtrWeb.UserController do
  use PtrWeb, :controller

  alias Ptr.Accounts
  alias Ptr.Accounts.User

  plug :authenticate
  plug :put_breadcrumb, name: dgettext("users", "Users"), url: "/users"

  def index(%{assigns: %{current_session: session}} = conn, params) do
    page = Accounts.list_users(session.account, params)

    render(conn, "index.html", users: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})

    conn
    |> put_new_breadcrumb
    |> render("new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_session: session}} = conn, %{"user" => user_params}) do
    case Accounts.create_user(session, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, dgettext("users", "User created successfully."))
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(%{assigns: %{current_session: session}} = conn, %{"id" => id}) do
    user = Accounts.get_user!(session.account, id)

    conn
    |> put_show_breadcrumb(user)
    |> render("show.html", user: user)
  end

  def edit(%{assigns: %{current_session: session}} = conn, %{"id" => id}) do
    user      = Accounts.get_user!(session.account, id)
    changeset = Accounts.change_user(user)

    conn
    |> put_edit_breadcrumb(user)
    |> render("edit.html", user: user, changeset: changeset)
  end

  def update(%{assigns: %{current_session: session}} = conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(session.account, id)

    case Accounts.update_user(session, user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, dgettext("users", "User updated successfully."))
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(%{assigns: %{current_session: session}} = conn, %{"id" => id}) do
    user = Accounts.get_user!(session.account, id)
    {:ok, _user} = Accounts.delete_user(session, user)

    conn
    |> put_flash(:info, dgettext("users", "User deleted successfully."))
    |> redirect(to: user_path(conn, :index))
  end

  defp put_new_breadcrumb(conn) do
    name = dgettext("users", "New user")
    url  = user_path(conn, :new)

    conn |> put_breadcrumb(name, url)
  end

  defp put_show_breadcrumb(conn, user) do
    name = dgettext("users", "User")
    url  = user_path(conn, :show, user)

    conn |> put_breadcrumb(name, url)
  end

  defp put_edit_breadcrumb(conn, user) do
    name = dgettext("users", "Edit user")
    url  = user_path(conn, :edit, user)

    conn |> put_breadcrumb(name, url)
  end
end
