defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase

  alias ExMon.Trainer

  describe "show/2" do
    test "when are passed a valid trainer id, return a trainer", %{conn: conn} do
      params = %{name: "Jorge", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "id" => _id,
               "inserted_at" => _inserted_at,
               "name" => "Jorge"
             } = response
    end

    test "When there is an Error, return the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "123"))
        |> json_response(:unprocessable_entity)

      expected_response = %{"message" => "Invalid ID format"}

      assert response == expected_response
    end
  end
end
