defmodule ExMonWeb.WelcomeController do
  use ExMonWeb, :controller

  def index(conn, _params) do
    text(conn, "Estou reaprendendo Elixir")
  end
end
