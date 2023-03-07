defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "When all params are valid return a valid changeset" do
      params = %{name: "renan", password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "renan",
                 password: "123456"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } = response
    end

    test "When pass invalid format password return a error" do
      params = %{name: "renan", password: "12345"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "renan",
                 password: "12345"
               },
               data: %ExMon.Trainer{},
               valid?: false
             } = response

      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end

  describe "build/1" do
    test "When all params are valid, returns  triner struct" do
      params = %{name: "renan", password: "123456"}

      response = Trainer.build(params)

      assert {:ok, %Trainer{name: "renan", password: "123456"}} = response
    end

    test "When there are invalid params returns an error" do
      params = %{password: "123456"}

      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
