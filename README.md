# Diceware

![](https://github.com/silbermm/diceware/workflows/Build/badge.svg)
![Hex.pm](https://img.shields.io/hexpm/v/diceware?style=flat-square)

An Elixir library to generate passphrases using the [Diceware](https://theworld.com/~reinhold/diceware.html) method.

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
```elixir
generated = Dicware.generate()
IO.inspect(generated.phrase)
```
will output something similar like `aliveallenhairmousyvault5555`

You can also specify how many words to use when building the passphrase
```elixir
generated = Diceware.generate(count: 10)
IO.inspect(generated.phrase)
```
will output a 10 word generated phrase like `barrebeastcrissethanfrancmabelswigswineuz57th`

Official docs available on [hex.pm](https://hexdocs.pm/diceware/0.2.6/Diceware.html)
