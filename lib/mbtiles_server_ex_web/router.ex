defmodule MbtilesServerExWeb.Router do
  use MbtilesServerExWeb, :router

  pipeline :vector_tiles do
    plug :accepts, ["pbf"]

    plug Corsica,
      origins: ["http://localhost:8000"],
      allow_headers: ["accept", "content-type", "authorization"],
      allow_credentials: true
  end

  scope "/" do
    pipe_through [:vector_tiles]

    get "/tiles/:z/:x/:y", MbtilesServerExWeb.TileController, :show
  end
end
