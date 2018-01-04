defmodule BookcaseApiWeb.PageController do
  use BookcaseApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
