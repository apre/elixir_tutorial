# DeviceManager


# Database configuration

Create two Databases.

devicemanager
  - user: devicemanager
  - password: devicemanager


devicemanager_dev
  - user: devicemanager_dev
  - password: devicemanager_dev


## deps

```elixir
{:ecto, "~> 2.0"},
{:postgrex, "~> 0.11"}
{:guardian, "~> 1.0"},
{:comeonin, "~> 4.0"},
{:pbkdf2_elixir, "~> 0.12"}
#{:bcrypt_elixir, "~> 0.12"},
```

# bootstrap

## create user context
```
mix phx.gen.context UserManager User users username:string password:string
mix phx.gen.html UserManager User users username:string password:string
mix phx.gen.html UserManager User users
```


```
mix guardian.gen.secret
```

# other


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
