defmodule ThirdDayExampleTest do
  use ExUnit.Case
  doctest ThirdDayExample

  test "greets the world" do
    assert ThirdDayExample.hello() == :world
  end
end
