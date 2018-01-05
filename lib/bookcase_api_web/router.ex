defmodule BookcaseApiWeb.Router do
  use BookcaseApiWeb, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  # scope "/", BookcaseApiWeb do
  #   pipe_through :browser # Use the default browser stack

  #   get "/", PageController, :index
  #   get "/hello", HelloController, :index
  #   get "/hello/:messenger", HelloController, :show
  # end

  scope "/api", BookcaseApiWeb do
    pipe_through :api
  end
end
