defmodule Photomap.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(PhotomapWeb.Endpoint, []),
      worker(Cachex, [ :tile_cache, [] ]),
      :hackney_pool.child_spec(:first_pool, [timeout: 15000, max_connections: 100])
      # Start your own worker by calling: Photomap.Worker.start_link(arg1, arg2, arg3)
      # worker(Photomap.Worker, [arg1, arg2, arg3]),
    ]
	
	:ok = :hackney_pool.start_pool(:osm_pool, [timeout: 60000, max_connections: 50])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Photomap.Supervisor]
    Supervisor.start_link(children, opts)
 
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhotomapWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
