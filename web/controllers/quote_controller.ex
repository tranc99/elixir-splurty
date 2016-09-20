defmodule Splurty.QuoteController do
  use Splurty.Web, :controller
  alias Splurty.Router
  import Splurty.Router.Helpers

  plug :action

  def homepage(conn, _params) do
    render conn, "homepage.html"
  end


  def index(conn, _params) do
    conn
    |> assign(:quotes, Splurty.Repo.all(Splurty.Quote))
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> assign(:quotes, Splurty.Repo.all(Splurty.Quote))
    |> render "new.html"
  end
end
