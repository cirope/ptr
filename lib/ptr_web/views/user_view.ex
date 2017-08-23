defmodule PtrWeb.UserView do
  use PtrWeb, :view
  use Scrivener.HTML

  def fullname(user) do
    Enum.join([user.name, user.lastname], " ")
  end

  def link_to_show(conn, user) do
    link dgettext("users", "Show"), to: user_path(conn, :show, user), class: "button is-small"
  end

  def link_to_edit(conn, user) do
    link dgettext("users", "Edit"), to: user_path(conn, :edit, user), class: "button is-small"
  end

  def link_to_delete(conn, user) do
    link dgettext("users", "Delete"),
      to:     user_path(conn, :delete, user),
      method: :delete,
      data:   [confirm: dgettext("users", "Are you sure?")],
      class:  "button is-small is-danger"
  end

  def lock_version_input(_, nil), do: nil
  def lock_version_input(form, user) do
    hidden_input form, :lock_version, [value: user.lock_version]
  end

  def submit_button(user) do
    submit_label(user)
    |> submit(class: "button is-medium is-white is-paddingless card-footer-item")
  end

  defp submit_label(nil), do: dgettext("users", "Create")
  defp submit_label(_),   do: dgettext("users", "Update")
end
