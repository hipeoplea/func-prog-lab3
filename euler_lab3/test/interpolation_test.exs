defmodule MyLab3.InterpolationTest do
  use ExUnit.Case, async: true

  alias MyLab3.Interpolation.{Linear, Newton}

  @points [{0.0, 0.0}, {1.0, 1.0}, {2.0, 4.0}, {3.0, 9.0}]

  test "linear interpolation between nearest neighbours" do
    assert Linear.value(@points, 0.5) == 0.5
    assert Linear.value(@points, 1.5) == 2.5
    assert Linear.value(@points, -1.0) == nil
  end

  test "newton interpolation uses window of closest points" do
    assert_in_delta Newton.value(@points, 1.5, 3), 2.25, 1.0e-6
    assert_in_delta Newton.value(@points, 2.5, 3), 6.25, 1.0e-6
  end
end
