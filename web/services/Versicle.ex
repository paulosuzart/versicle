defmodule Web.Versicle do
 require YamlElixir
 use GenServer

 def start_link(name) do
   GenServer.start_link(__MODULE__, :ok, name: name)
 end

 def suggest(pid) do
   GenServer.call(pid, :suggest)
 end

 def handle_call(:suggest, _from, [src| [len, keys, table]]) do

  book_idx = :rand.uniform(len) - 1
  book = Enum.at(keys, book_idx)
  chapters = Map.get(table, book)
  chapter_idx = :rand.uniform(length(chapters)) - 1
  verse = :rand.uniform(chapters |> Enum.at(chapter_idx)) - 1
  {:reply, "#{book}#{chapter_idx + 1}-#{verse}", [src, len, keys, table]}
 end

def init(:ok) do
  src = "./bible.yaml" |> Path.expand(__DIR__)
  table = src |> YamlElixir.read_from_file
  keys = Map.keys(table)
  len = length(keys)
  {:ok ,[src, len, keys, table]}
end

end
