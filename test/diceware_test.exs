defmodule DicewareTest do
  use ExUnit.Case
  use ExUnitProperties

  doctest Diceware

  test "generates random password with 6 words" do
    passphrase = Diceware.generate()
    assert passphrase.count == 6
  end

  property "random numbers are always below 8192" do
    check all num <- integer(1..10) do
      nums = Diceware.random_numbers(num)
      assert Enum.max(nums) < 8192
    end
  end

  property "password count is always the correct size" do
    check all num <- integer(1..10) do
      passphrase = Diceware.generate(count: num)
      assert passphrase.count == num
    end
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
    # pass = Passphrase.new(["word", "another", "random", "2", "3", "4", "5"])
    pass = Diceware.generate(count: 7)

    assert Diceware.with_colors(pass) ==
             "\e[36m#{Enum.at(pass.words, 0)}\e[35m#{Enum.at(pass.words, 1)}\e[33m#{
               Enum.at(pass.words, 2)
             }\e[34m#{Enum.at(pass.words, 3)}\e[32m#{Enum.at(pass.words, 4)}\e[31m#{
               Enum.at(pass.words, 5)
             }\e[36m#{Enum.at(pass.words, 6)}"
  end
end
