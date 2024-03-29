defmodule ExMonWeb.Router do
  use ExMonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ExMonWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExMonWeb.Auth.Pipeline
  end

  # scope "/", ExMonWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api", ExMonWeb do
    pipe_through :api
    post "/trainers", TrainersController, :create

    get "/pokemons/:name", PokemonsController, :show

    post "trainers/signin", TrainersController, :sign_in
  end

  scope "/api", ExMonWeb do
    pipe_through [:api, :auth]
    resources "/trainers", TrainersController, only: [:show, :delete, :update]

    resources "/trainer_pokemons", TrainerPokemonsController,
      only: [:create, :show, :delete, :update]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExMonWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", ExMonWeb do
    pipe_through :api

    get "/", WelcomeController, :index
  end
end
