defmodule ExMon.Traainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Repo, Trainer}
  alias Trainer.Create

  describe "call/1" do
    test "When all params are valid, create a trainer" do
      params = %{name: "Bruno", password: "123456"}

      count_before = Repo.aggregate(Trainer, :count)

      response = Create.call(params)

      count_afters = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "Bruno"}} = response
      assert count_before < count_afters
    end

    test "When there are invalid params, return an error" do
      params = %{name: "Bruno"}

      response = Create.call(params)

      assert {:error, changeset} = response

      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
