defmodule MyLab3.StreamProcessorTest do
  use ExUnit.Case, async: true

  alias MyLab3.{Options, StreamProcessor}

  test "streaming linear interpolation with accumulation of outputs" do
    opts = %Options{algorithms: [:linear], step: 0.5, window: 4}
    input = ["0 0\n", "1 1\n", "2 2\n"]

    StreamProcessor.run(opts, input, fn line ->
      send(self(), {:out, line})
    end)

    assert collected() == [
             "linear: 0.0 0.0",
             "linear: 0.5 0.5",
             "linear: 1.0 1.0",
             "linear: 1.5 1.5",
             "linear: 2.0 2.0"
           ]
  end

  test "linear and newton can be enabled together" do
    opts = %Options{algorithms: [:linear, :newton], step: 1.0, window: 3}
    input = ["0 0\n", "1 1\n", "3 9\n"]

    StreamProcessor.run(opts, input, fn line ->
      send(self(), {:out, line})
    end)

    assert collected() == [
             "linear: 0.0 0.0",
             "newton: 0.0 0.0",
             "linear: 1.0 1.0",
             "newton: 1.0 1.0",
             "linear: 2.0 5.0",
             "newton: 2.0 4.0",
             "linear: 3.0 9.0",
             "newton: 3.0 9.0"
           ]
  end

  defp collected(acc \\ []) do
    receive do
      {:out, line} -> collected([line | acc])
    after
      0 -> Enum.reverse(acc)
    end
  end
end
