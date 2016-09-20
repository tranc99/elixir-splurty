defmodule Splurty.QuoteController do
  use Splurty.Web, :controller

  plug :action

  def homepage(conn, _params) do
    render conn, "homepage.html"
  end


  def index(conn, _params) do
    render conn, "index.html" 
  end
end
