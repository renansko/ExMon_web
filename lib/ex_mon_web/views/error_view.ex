defmodule ExMonWeb.ErrorView do
  use ExMonWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def render("error.json", %{result: %Ecto.Changeset{} = result}) do
    %{message: translate_errors(result)}
  end

  def render("error.json", %{result: message}) do
    %{message: message}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
