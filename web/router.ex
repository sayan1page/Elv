defmodule ArticleApi.Router do
  use ArticleApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
    #plug :put_secure_browser_headers
	plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
	#plug :accepts, ["text"]
  end

  pipeline :api do
	plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
	#plug :accepts, ["text"]
  end

  scope "/", ArticleApi do
    pipe_through :browser # Use the default browser stack

    get "/articles", PageController, :all
	get "/articles/:id", PageController, :by_id
	post "/articlesbyid/", PageController, :by_key
	options "/articlesbyid/", PageController, :nohing
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArticleApi do
  #   pipe_through :api
  # end
end
