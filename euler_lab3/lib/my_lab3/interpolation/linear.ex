defmodule MyLab3.Interpolation.Linear do
  @moduledoc """
  Линейная интерполяция отрезками.
  """

  @spec value([{float(), float()}], float()) :: float() | nil
  def value(points, x) do
    points
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.find_value(fn [{x1, y1}, {x2, y2}] ->
      if x >= x1 and x <= x2 do
        t = (x - x1) / (x2 - x1)
        y1 + t * (y2 - y1)
      end
    end)
  end
end
