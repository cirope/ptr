defmodule Ptr.Accounts.MigrationTest do
  use Ptr.DataCase

  alias Ptr.Accounts
  alias Ptr.Accounts.Migration

  describe "accounts" do
    test "account_prefixes/0 returns all account prefixes" do
      account = fixture(:seed_account)

      assert Migration.account_prefixes() == [Accounts.prefix(account)]
    end
  end
end
