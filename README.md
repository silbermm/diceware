![Hex.pm](https://img.shields.io/hexpm/v/diceware?style=flat-square)

# Diceware

Generate passphrases using the [Diceware](https://theworld.com/~reinhold/diceware.html) method.

## Installation

Add `diceware` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:diceware, "~> x.x.x"}
  ]
end
```

## Usage

Ask for a new password and get a `Diceware.Passphrase` back
```
iex> passphrase = Dicware.generate()
%Diceware.Passphrase{}

iex> passphrase.phrase
boundfreakolavwho3a9z
```

Specify how many words to use when building the passphrase
```
Diceware.generate(count: 10)
barrebeastcrissethanfrancmabelswigswineuz57th
```

Official docs available on [hex.pm](https://hex.pm/diceware)
