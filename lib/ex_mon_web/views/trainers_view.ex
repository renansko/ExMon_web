defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  alias ExMon.Trainer

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      name: name,
      id: id,
      inserted_at: inserted_at
    }
  end

  def render("update.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at,
          updated_at: updated_at
        }
      }) do
    %{
      message: "Trainer Updated!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end
end
