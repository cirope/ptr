defmodule PtrWeb.BreadcrumbPlugTest do
  use PtrWeb.ConnCase, async: true

  alias PtrWeb.BreadcrumbPlug

  describe "breadcrumb" do
    test "add breadcrumb", %{conn: conn} do
      conn = BreadcrumbPlug.put_breadcrumb(conn, name: "Test", url: "/test")

      assert conn.assigns.breadcrumbs ==
        [%{name: "Test", url: "/test", active: nil}]
    end
  end
end
