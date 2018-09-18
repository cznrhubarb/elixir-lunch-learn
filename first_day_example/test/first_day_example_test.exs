defmodule FirstDayExampleTest do
  use ExUnit.Case
  doctest FirstDayExample

  test "greets the world" do
    assert FirstDayExample.hello() == :world
  end
end
