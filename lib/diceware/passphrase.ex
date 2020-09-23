defmodule Diceware.Passphrase do
  @moduledoc """
  Models a passphrase.
  """

  alias IO.ANSI
  alias __MODULE__

  @type t :: %Passphrase{
          words: list(),
          phrase: String.t() | nil,
          count: number()
        }

  defstruct words: [], phrase: nil, count: 0, errors: nil

  @colors [ANSI.cyan(), ANSI.magenta(), ANSI.yellow(), ANSI.blue(), ANSI.green(), ANSI.red()]

  @doc false
  @spec new(list()) :: Passphrase.t()
  def new(words) when is_list(words) do
    %Passphrase{
      words: words,
      phrase: Enum.join(words),
      count: Enum.count(words)
    }
  end
  def new(_words), do: %Passphrase{errors: [:invalid_wordlist]}

  @doc ~S"""
  Return a string of the password with ANSI colors for printing to the console

  ## Examples

      iex> passphrase = Diceware.Passphrase.new(["a", "b", "c"])
      iex> Diceware.Passphrase.with_colors(passphrase)
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
    do: Enum.map(0..word_size-1, &Enum.at(@colors, &1))

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
