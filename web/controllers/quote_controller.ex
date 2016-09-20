defmodule Splurty.QuoteController do
  use Splurty.Web, :controller
  alias Splurty.Router
  import Splurty.Router.Helpers

  # plug :action

  def homepage(conn, _params) do
    render conn, "homepage.html"
  end


  def index(conn, _params) do
    conn
    |> assign(:quotes, Splurty.Repo.all(Splurty.Quote))
    |> render("index.html")
  end

  def new(conn, _params) do
    changeset = Splurty.Quote.changeset(%Splurty.Quote{})
    conn
    |> assign(:changeset, changeset)
    |> render("new.html")
  end

  def create(conn, params) do
    q = %Splurty.Quote{saying: params["quote"]["saying"], author: params["quote"]["author"]}
    Splurty.Repo.insert(q)
    redirect conn, to: quote_path(conn, :index)
  end
end
