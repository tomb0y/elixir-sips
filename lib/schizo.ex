defmodule Schizo do
  @moduledoc false

  require Integer

  @vowels ~w[a i u e o]

  @doc ~S"""
  Upcases every other word in a sentece.

  ## Examples

      iex> Schizo.uppercase("elixir is pretty rad")
      "elixir IS pretty RAD"

  """
  def uppercase(str) do
    str
    |> transform_every_other_word_with(&String.upcase/1)
  end

  @doc ~S"""
  Removes the vowels from every other word in a sentence.

  ## Examples

      iex> Schizo.unvowel("how are things really?")
      "how r things rlly?"

  """
  def unvowel(str) do
    str
    |> transform_every_other_word_with(&(String.replace(&1, @vowels, "")))
  end

  defp transform_every_other_word_with(str, transformer) do
    str
    |> String.split(" ")
    |> transform_every_other_item_with(transformer)
    |> Enum.join(" ")
  end

  defp transform_every_other_item_with(list, transformer) do
    list
    |> Stream.with_index
    |> Enum.map(transform_odd_index_item_with(transformer))
  end

  defp transform_odd_index_item_with(transformer) do
    fn
      ({item, index}) when Integer.is_even(index) -> item
      ({item, index}) when Integer.is_odd(index) -> transformer.(item)
    end
  end
end
