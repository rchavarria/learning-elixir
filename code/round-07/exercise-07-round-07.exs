defmodule WordCountServer do

  def parse(scheduler, dir) do
    send scheduler, { :ready, self }

    receive do
      { :count, file } ->
        IO.puts "Proceso #{inspect self} contando fichero #{file}"

        word_count = count_words_on(dir, file)
        send scheduler, { :answer, file, word_count }
        # sigue escuchando
        parse(scheduler, dir)

      { :shutdown } ->
        exit(:normal)
    end
  end

  defp count_words_on(dir, file) do
    path = dir <> "/" <> file
    contents = path |> File.read!
    word_count = length(String.split(contents, "cat")) - 1
    word_count
  end

end

defmodule Scheduler do

  def run(dir) do
    files = File.ls!(dir)

    files
    |> Enum.map(fn(_) -> spawn_link(WordCountServer, :parse, [ self, dir ]) end)
    |> schedule_processes(files, [])
  end

  defp schedule_processes(pids, files, results) do
    receive do
      { :ready, server } when length(files) > 0 ->
        [ next_file | tail ] = files
        send server, { :count, next_file }
        schedule_processes(pids, tail, results)

      { :ready, server } ->
        send server, { :shutdown }
        if length(pids) > 1 do
          schedule_processes(List.delete(pids, server), files, results)
        else
          results
        end

      { :answer, file, word_count } ->
        result = "El fichero #{file} contiene #{word_count} cats"
        schedule_processes(pids, files, [ result | results ])
    end
  end

end

#
# Uso del planificador y del servidor
#
target_dir = "target"
Scheduler.run(target_dir)
  |> Enum.each(&IO.puts/1)

