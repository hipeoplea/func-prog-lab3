defmodule MyLab3.Options do
  @moduledoc """
  Разбор аргументов командной строки и хранение настроек расчётов.
  """

  defstruct algorithms: [:linear], step: 0.1, window: 4

  @type t :: %__MODULE__{
          algorithms: [atom()],
          step: float(),
          window: pos_integer()
        }

  @spec parse([String.t()]) :: t
  def parse(argv) do
    {opts, _, _} =
      OptionParser.parse(argv,
        switches: [
          linear: :boolean,
          newton: :boolean,
          step: :float,
          n: :integer
        ]
      )

    algorithms = pick_algorithms(opts)
    step = Keyword.get(opts, :step, 0.1)
    window = Keyword.get(opts, :n, 4)

    validate!(step, window)

    %__MODULE__{algorithms: algorithms, step: step, window: window}
  end

  defp pick_algorithms(opts) do
    enabled =
      [:linear, :newton]
      |> Enum.filter(fn alg -> Keyword.get(opts, alg, false) end)

    case enabled do
      [] -> [:linear]
      list -> list
    end
  end

  defp validate!(step, _window) when step <= 0.0 do
    raise ArgumentError,
          "шаг (--step) должен быть положительным, получено #{inspect(step)}"
  end

  defp validate!(_step, window) when not is_integer(window) or window < 2 do
    raise ArgumentError,
          "размер окна (-n) должен быть целым числом >= 2, получено #{inspect(window)}"
  end

  defp validate!(_step, _window), do: :ok
end
