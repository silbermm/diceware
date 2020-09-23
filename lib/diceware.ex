defmodule Diceware do
  @moduledoc """
  A library that generates a [Diceware](https://theworld.com/~reinhold/diceware.html) passphrase.

  A diceware passphrase builds a readable passphrase of 6 (or more) words from a list of 8,192 words.

  Creating a passphrase combining readable words helps the user more easily memorize it.
  """

  @doc """
  Generate a passphrase with at least 6 words. Takes an optional number of words parameter.
  """
  @spec generate(number()) :: Diceware.Passphrase.t()
  def generate(number \\ 6) do
    randoms = random_numbers(number)

    file_stream()
    |> Stream.with_index()
    |> Stream.filter(fn {_word, index} ->
      Enum.member?(randoms, index)
    end)
    |> Stream.map(&get_word/1)
    |> Enum.to_list()
    |> Diceware.Passphrase.new()
  end

  @doc """
  Writes the passphrase to the screen. Takes a keyword list of options. Supported options include:

    * color: true | false
      use ANSI colors when printing - Each part of the passphrase will be a different color

  """
  @spec print(Diceware.Passphrase.t(), Keyword.t()) :: :ok
  def print(%Diceware.Passphrase{} = phrase, opts \\ []) do
    color = Keyword.get(opts, :color, false)

    if color do
      IO.write(Diceware.Passphrase.with_colors(phrase) <> "\n")
    else
      IO.write(phrase.phrase <> "\n")
    end
  end

  defp get_word({word, _}), do: String.trim(word)
  defp get_word(_), do: ""

  defp random_numbers(number), do: Enum.map(1..number, fn _ -> Enum.random(1..8_192) end)

  defp file_stream() do
    :diceware
    |> :code.priv_dir()
    |> Path.join("diceware.txt")
    |> File.stream!()
  end
end
