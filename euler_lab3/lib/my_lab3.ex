defmodule MyLab3 do
  @moduledoc """
  Потоковая интерполяция с линейным и ньютоновским алгоритмами.
  """

  alias MyLab3.{Options, StreamProcessor}

  def run(argv, input_stream \\ IO.stream(:stdio, :line), output_fun \\ &IO.puts/1) do
    argv
    |> Options.parse()
    |> StreamProcessor.run(input_stream, output_fun)
  end
end
