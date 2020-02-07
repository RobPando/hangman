defmodule SocketPhxClientWeb.PageController do
  use SocketPhxClientWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
