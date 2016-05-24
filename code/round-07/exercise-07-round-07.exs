defmodule WordCountServer do

  def parse(scheduler, dir, file) do
    path = dir <> "/" <> file
    contents = path
      |> File.read!
    word_count = length(String.split(contents, "cat")) - 1

    send scheduler, { file, word_count, self }
  end

end

defmodule Scheduler do

  def run(dir) do
    dir
    |> File.ls!
    |> Enum.map(fn(file) -> spawn_link(WordCountServer, :parse, [ self, dir, file ]) end)
    |> gather_counts
  end

  defp gather_counts([]), do: nil
  defp gather_counts(pids) do
    receive do
      { file, word_count, pid } ->
        IO.puts "File #{file} contains #{word_count} cat words"
        # recibe el siguiente resultado
        gather_counts(List.delete(pids, pid))
    end
  end

end

#
# Uso del planificador y del servidor
#
target_dir = "target"
Scheduler.run target_dir

