defmodule FlextimeWeb.PageController do
  use FlextimeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
