defmodule PhotomapWeb.Router do
  use PhotomapWeb, :router
  

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhotomapWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
  end

  scope "/api/v1", PhotomapWeb, as: :api_v1 do
    get "/tiles/:imageIdent/:subMachine/:zoom/:xcoord/:ycoord", TilesController, :fetch
  end

  

  # Other scopes may use custom stacks.
  # scope "/api", PhotomapWeb do
  #   pipe_through :api
  # end
end
