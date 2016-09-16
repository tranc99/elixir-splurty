defmodule Splurty.Router do
  use Splurty.Web, :router

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

  scope "/", Splurty do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    get "/", QuoteController, :homepage
  end

  # Other scopes may use custom stacks.
  # scope "/api", Splurty do
  #   pipe_through :api
  # end
end
