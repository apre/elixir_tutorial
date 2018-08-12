defmodule PhotomapWeb.HelloController do
    use PhotomapWeb, :controller
    require Logger
    def index(conn, params) do
        Logger.debug "HelloController:index: #{inspect(params)}"
        conn
  #      |> assign(:message, "Welcome Back!")
        |> text("hello you")
       
      end
  end