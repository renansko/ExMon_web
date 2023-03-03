defmodule ExMonWeb.PageController do
  use ExMonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
