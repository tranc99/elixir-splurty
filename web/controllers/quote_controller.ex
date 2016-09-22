defmodule Splurty.QuoteController do
  use Splurty.Web, :controller
  alias Splurty.Router
  import Splurty.Router.Helpers

  # plug :action

  def homepage(conn, _params) do
    quotes_count = Splurty.Repo.aggregate(Splurty.Quote, :count, :id)
    myoffsets = :rand.uniform(quotes_count - 1)
    quote = Ecto.Query.offset(Splurty.Quote, ^myoffsets) |> Ecto.Query.first |> Splurty.Repo.one
    render(conn, "homepage.html", quote: quote)
  end


  def index(conn, _params) do
    conn
    |> assign(:quotes, Splurty.Repo.all(Splurty.Quote))
    |> render("index.html")
  end


  def show(conn, params) do
     quote = Splurty.Quote |> Splurty.Repo.get(params["id"])
     conn
     |> assign(:quote, quote)
     |> render("show.html")
  end

  def edit(conn, params) do
     quote = Splurty.Quote |> Splurty.Repo.get(params["id"])
     changeset = Splurty.Quote.changeset(quote)
     conn
     |> assign(:quote, quote)
     |> assign(:changeset, changeset)
     |> render("edit.html")
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

  def update(conn, params) do
    quote = Splurty.Quote |> Ecto.Query.first |> Splurty.Repo.get(params["id"])
    changeset = Splurty.Quote.changeset(quote, params["quote"])
    case Splurty.Repo.update(changeset) do
      {:ok, quote} ->
        conn
        |> put_flash(:info, "Quote updated successfully")
        |> redirect(to: quote_path(conn, :show, quote.id))
      {:error, changeset}
        conn
        |> put_flash(:info, changeset.errors)
        |> render("edit.html", quote: quote, changeset: changeset)
    end
  end

  def delete(conn, params) do
    quote = Splurty.Quote |> Ecto.Query.first |> Splurty.Repo.get(params["id"])
    case Splurty.Repo.delete(quote) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Quote was deleted.")
        |> redirect(to: quote_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:info, "An error occured. Quote was not deleted.")
        |> redirect(to: quote_path(conn, :index))
    end
  end

end
