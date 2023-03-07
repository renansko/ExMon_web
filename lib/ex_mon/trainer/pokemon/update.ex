defmodule ExMon.Trainer.Pokemon.Update do
  alias Ecto.UUID

  alias ExMon.{Trainer.Pokemon, Repo}

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format", :unprocessable_entity}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => uuid} = params) do
    case Repo.get(Pokemon, uuid) do
      nil -> {:error, "Pokemon not found!", :not_found}
      pokemon -> update_pokemon(pokemon, params)
    end
  end

  defp update_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end
end
