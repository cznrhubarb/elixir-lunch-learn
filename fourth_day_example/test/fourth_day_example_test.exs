defmodule FourthDayExampleTest do
  use ExUnit.Case
  doctest FourthDayExample

  test "greets the world" do
    assert FourthDayExample.hello() == :world
  end
end
