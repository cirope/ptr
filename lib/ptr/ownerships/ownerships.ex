defmodule Ptr.Ownerships do
  @moduledoc """
  The Ownerships context.
  """

  import Ecto.Query, warn: false
  alias Ptr.Repo

  alias Ptr.Ownerships.Owner

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners(%Account{})
      [%Owner{}, ...]

  """
  def list_owners(account, params) do
    Owner
    |> prefixed(account)
    |> Repo.paginate(params)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123, %Account{})
      %Owner{}

      iex> get_owner!(456, %Account{})
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id, account) do
    Owner
    |> prefixed(account)
    |> Repo.get!(id)
  end

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value}, %Account{})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs, account) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Map.put(:repo_opts, prefix: prefix(account))
    |> PaperTrail.insert(prefix: prefix(account))
    |> extract_model()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value}, %Account{})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value}, %Account{})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs, account) do
    owner
    |> Owner.changeset(attrs)
    |> PaperTrail.update(prefix: prefix(account))
    |> extract_model()
  end

  @doc """
  Deletes a Owner.

  ## Examples

      iex> delete_owner(owner, %Account{})
      {:ok, %Owner{}}

      iex> delete_owner(owner, %Account{})
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner, account) do
    owner
    |> PaperTrail.delete(prefix: prefix(account))
    |> extract_model()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{source: %Owner{}}

  """
  def change_owner(%Owner{} = owner) do
    Owner.changeset(owner, %{})
  end

  defp prefixed(query, account) do
    query
    |> Ecto.Queryable.to_query()
    |> Map.put(:prefix, prefix(account))
  end

  defp prefix(account) do
    "t_#{account.db_prefix}"
  end

  defp extract_model({:ok, %{model: model}}), do: {:ok, model}
  defp extract_model(error),                  do: error
end
