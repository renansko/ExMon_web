defmodule ExMonWeb.FallBackController do
  use ExMonWeb, :controller

  def call(conn, {:error, result, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExMonWeb.ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, result, :unprocessable_entity}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ExMonWeb.ErrorView)
    |> render("error.json", result: result)
  end

  def call(conn, {:error, result, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ExMonWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
