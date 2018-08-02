# Friends

Friends tutorial from https://hexdocs.pm/ecto/getting-started.html

## bootstrap

```
mix new friends --sup
mix deps.get
mix ecto.gen.repo -r Friends.Repo


mix ecto.create
mix ecto.gen.migration create_people


mix ecto.migrate

```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `friends` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:friends, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/friends](https://hexdocs.pm/friends).

