defmodule MyLab3.CLI do
  @moduledoc """
  Читаем stdin построчно и пишет результаты в stdout.
  """

  alias MyLab3.{Options, StreamProcessor}

  @spec main([String.t()]) :: :ok
  def main(argv) do
    argv
    |> Options.parse()
    |> StreamProcessor.run(IO.stream(:stdio, :line), &IO.puts/1)
  end
end
