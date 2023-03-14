defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase

  import ExMonWeb.Auth.Guardian

  alias ExMon.Trainer

  describe "show/2" do
    setup %{conn: conn} do
      params = %{name: "admin", password: "admin123"}
      {:ok, trainer} = ExMon.create_trainer(params)
      {:ok, token, _clains} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

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
