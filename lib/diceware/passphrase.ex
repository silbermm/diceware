defmodule Diceware.Passphrase do
  @moduledoc false

  alias IO.ANSI
  alias __MODULE__

  @type t :: %Passphrase{
          words: list(),
          phrase: String.t() | nil,
          number_of_words: number()
        }

  defstruct words: [], phrase: nil, number_of_words: 0

  @colors [ANSI.cyan(), ANSI.magenta(), ANSI.yellow(), ANSI.blue(), ANSI.green(), ANSI.red()]

  @spec new(list()) :: Passphrase.t()
  def new(words) do
    %Passphrase{
      words: words,
      phrase: Enum.join(words),
      number_of_words: Enum.count(words)
    }
  end

  @spec with_colors(Passphrase.t()) :: String.t()
  def with_colors(%Passphrase{} = passphrase) do
    passphrase.number_of_words
    |> color_list()
    |> Enum.zip(passphrase.words)
    |> Enum.map(fn {c, w} -> c <> w end)
    |> Enum.join()
  end

  defp color_list(word_size) when word_size <= 6,
    do: Enum.map(1..word_size, &Enum.at(@colors, &1))

  defp color_list(word_size) do
    number_of_color_lists = div(word_size, Enum.count(@colors))
    extra_colors = rem(word_size, Enum.count(@colors))

    colors =
      Enum.reduce(0..number_of_color_lists, [], fn _x, acc ->
        acc ++ @colors
      end)

    colors ++ Enum.take(@colors, extra_colors)
  end
end
