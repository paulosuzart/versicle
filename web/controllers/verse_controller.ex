defmodule Web.VerseController do
  use Web.Web, :controller

  def index(conn, _params) do
    verse = Web.Versicle.suggest(Web.Versicle)
    render conn, "index.html", verse: verse
  end
end
