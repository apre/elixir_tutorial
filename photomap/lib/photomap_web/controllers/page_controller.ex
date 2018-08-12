defmodule PhotomapWeb.PageController do
  use PhotomapWeb, :controller

  require Logger


  def index(conn, params) do
    Logger.info  "Logging this text!"
    Logger.debug "Var value: #{inspect(params)}"
    #Logger.debug "Var value: #{inspect(conn)}"

    conn
    #|> put_flash(:info, "Welcome to Phoenix, from flash info!")
    #|> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")

  end
end
