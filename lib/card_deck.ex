defmodule CardDeck do
  @moduledoc false

  def make_deck do
    card_suits = [:spades, :clubs, :diamonds, :hearts]
    card_values = [:a, 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k]

    for value <- card_values, suite <- card_suits, do: {:card, value, suite}
  end
end
