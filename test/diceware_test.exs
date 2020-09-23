defmodule DicewareTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Diceware


  test "generates random password with 6 words" do
    passphrase = Diceware.generate() 
    assert passphrase.count == 6
  end

  test "generates random password - custom length" do
    passphrase = Diceware.generate(8) 
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

  test "prints passphrase to screen" do
    passphrase = Diceware.generate() 
    assert capture_io(fn -> Diceware.print(passphrase) end) == passphrase.phrase <> "\n"
  end

  test "prints passphrase to screen with color" do
    passphrase = Diceware.generate() 
    with_colors = Diceware.Passphrase.with_colors(passphrase)
    assert capture_io(fn -> Diceware.print(passphrase, color: true) end) == with_colors <> "\n"
  end
end
