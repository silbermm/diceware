defmodule Diceware do
  @moduledoc """
  A library that generates a [Diceware](https://theworld.com/~reinhold/diceware.html) passphrase.

  A diceware passphrase builds a readable passphrase of 6 (or more) words from a list of 8,192 words.

  Creating a passphrase combining readable words helps the user more easily memorize it.
  """

  alias Diceware.Passphrase
  alias IO.ANSI

  require Logger

  @colors [ANSI.cyan(), ANSI.magenta(), ANSI.yellow(), ANSI.blue(), ANSI.green(), ANSI.red()]

  @doc ~S"""
  Generate a passphrase with at least 6 words.

  Takes a keyword list of options:

    * `:count` - number of words in phrase, defaults to 6

  """
  @spec generate(Keyword.t()) :: Diceware.Passphrase.t()
  def generate(opts \\ []) do
    number = Keyword.get(opts, :count, 6)
    randoms = random_numbers(number)

    Diceware.Words.all()
    |> Stream.with_index()
    |> Stream.filter(fn {_word, index} ->
      Enum.member?(randoms, index)
    end)
    |> Stream.map(&get_word/1)
    |> Enum.to_list()
    |> Diceware.Passphrase.new()
  end

  defp get_word({word, _}), do: String.trim(word, "\n")
  defp get_word(_), do: ""

  @doc false
  def random_numbers(number), do: Enum.map(1..number, fn _ -> Enum.random(0..8_191) end)

  @doc ~S"""
  Return a string of the password with ANSI colors for printing to the console

  ## Examples

      iex> passphrase = Diceware.Passphrase.new(["a", "b", "c"])
      iex> Diceware.with_colors(passphrase)
      "\e[36ma\e[35mb\e[33mc"

  """
  @spec with_colors(Passphrase.t()) :: String.t()
  def with_colors(%Passphrase{} = passphrase) do
    passphrase.count
    |> color_list()
    |> Enum.zip(passphrase.words)
    |> Enum.map(fn {c, w} -> c <> w end)
    |> Enum.join()
  end

  defp color_list(word_size) when word_size <= 6,
    do: Enum.map(0..(word_size - 1), &Enum.at(@colors, &1))

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
