defmodule DicewareTest do
  use ExUnit.Case
  doctest Diceware

  alias Diceware.Passphrase

  test "generates random password with 6 words" do
    passphrase = Diceware.generate()
    assert passphrase.count == 6
  end

  test "generates random password - custom length" do
    passphrase = Diceware.generate(number_of_words: 8)
    assert passphrase.count == 8
  end

  test "generates random password - unique" do
    passphrase = Diceware.generate()
    assert Enum.uniq(passphrase.words)
  end

  test "generates 2 passphrases not equal" do
    passphrase = Diceware.generate()
    passphrase2 = Diceware.generate()
    assert passphrase.phrase != passphrase2.phrase
  end

  test "with color - more than 6 words" do
    pass = Passphrase.new(["word", "another", "random", "2", "3", "4", "5"])

    assert Diceware.with_colors(pass) ==
             "\e[36mword\e[35manother\e[33mrandom\e[34m2\e[32m3\e[31m4\e[36m5"
  end
end
