defmodule ExMon.Trainer.Pokemon.Delete do
  alias Ecto.UUID

  alias ExMon.{Trainer.Pokemon, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "pokemon not found!"}
      pokemon -> Repo.delete(pokemon)
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
