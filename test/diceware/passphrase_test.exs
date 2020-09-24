defmodule Diceware.PassphraseTest do
  use ExUnit.Case, async: true
  doctest Diceware.Passphrase

  alias Diceware.Passphrase

  test "defaults" do
    pass = %Passphrase{}
    assert pass.count == 0
    assert pass.words == []
    assert pass.phrase == nil
  end

  test "create new passphrase from word list" do
    pass = Passphrase.new(["word", "another", "random", "2"])
    assert pass.count == 4
    assert pass.words == ["word", "another", "random", "2"]
    assert pass.phrase == "wordanotherrandom2"
  end
end
