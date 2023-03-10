defmodule ExMon.Trainer.Pokemon.Get do
  alias Ecto.UUID

  alias ExMon.{Trainer.Pokemon, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format", :unprocessable_entity}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Pokemon not found!", :not_found}
      pokemon -> {:ok, Repo.preload(pokemon, :trainer)}
    end
  end
end
