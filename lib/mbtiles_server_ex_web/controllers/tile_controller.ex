defmodule MbtilesServerExWeb.TileController do
  use MbtilesServerExWeb, :controller

  def show(conn, %{"z" => z, "x" => x, "y" => y} = _params) do
    case get_tile_data(z, x, get_tms_y(z, y)) do
      :error ->
        conn
        |> send_resp(404, "tile not found")

      tile_data ->
        conn
        |> prepend_resp_headers([{"content-encoding", "gzip"}])
        |> put_resp_content_type("application/octet-stream")
        |> send_resp(200, tile_data)
    end
  end

  # https://stackoverflow.com/a/53801783/4490927
  defp get_tms_y(z, y), do: round(:math.pow(2, String.to_integer(z)) - 1 - String.to_integer(y))

  defp get_tile_data(z, x, y) do
    sql = """
      SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?
    """

    with %{rows: [[tile_data]]} <- MbtilesServerEx.Repo.query!(sql, [z, x, y]) do
      tile_data
    else
      res ->
        res |> IO.inspect()
        :error
    end
  end
end
