defmodule Diceware.Passphrase do
  @moduledoc """
  Models a passphrase.
  """

  alias __MODULE__

  @type t :: %Passphrase{
          words: list(),
          phrase: String.t() | nil,
          count: number()
        }

  @derive {Jason.Encoder, only: [:words, :phrase, :count]}
  defstruct words: [], phrase: nil, count: 0

  @doc false
  @spec new(list()) :: Passphrase.t()
  def new(words) when is_list(words) do
    %Passphrase{
      words: words,
      phrase: Enum.join(words),
      count: Enum.count(words)
    }
  end

  @doc false
  def new(%{"count" => count, "words" => words, "phrase" => phrase}) do
    %Passphrase{
      words: words,
      phrase: phrase,
      count: count
    }
  end
end
