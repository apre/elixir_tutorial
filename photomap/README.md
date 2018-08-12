# Photomap


#

# start the project

## dev mode
```
iex.bat --werl -S mix phx.server
```

In erlang interactive shell:
```
:observer.start 


{ :ok, true } = Cachex.load(:tile_cache, "/tmp/tile_cache")

Cachex.dump(:tile_cache, "/tmp/tile_cache")
Cachex.size(:tile_cache)

Cachex.clear(:tile_cache)


```





To start your Phoenix server:

  * Install dependencies with `mix deps.get`
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

