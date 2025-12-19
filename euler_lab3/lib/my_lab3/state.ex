defmodule MyLab3.State do
  @moduledoc """
  Текущее состояние потокового расчёта.
  """

  defstruct points: [],
            step: 0.1,
            algorithms: [:linear],
            window: 4,
            next_x: nil

  @type t :: %__MODULE__{
          points: [{float(), float()}],
          step: float(),
          algorithms: [atom()],
          window: pos_integer(),
          next_x: float() | nil
        }
end
