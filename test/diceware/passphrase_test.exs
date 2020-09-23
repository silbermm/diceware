defmodule Diceware.PassphraseTest do
  use ExUnit.Case, async: true
  doctest Diceware.Passphrase

  alias Diceware.Passphrase

  test "defaults" do
    pass = %Passphrase{}
    assert pass.count == 0
    assert pass.words == []
    assert pass.phrase == nil
    assert pass.errors == nil
  end

  test "create new passphrase from word list" do
    pass = Passphrase.new(["word", "another", "random", "2"])
    assert pass.count == 4
    assert pass.words == ["word", "another", "random", "2"]
    assert pass.phrase == "wordanotherrandom2"
    assert pass.errors == nil
  end

  test "with color - more than 6 words" do
    pass = Passphrase.new(["word", "another", "random", "2", "3", "4", "5"])
    assert Passphrase.with_colors(pass) == "\e[36mword\e[35manother\e[33mrandom\e[34m2\e[32m3\e[31m4\e[36m5"
  end

  test "requires list of words" do
    pass = Passphrase.new("word")
    assert pass.errors == [:invalid_wordlist]
  end
end
