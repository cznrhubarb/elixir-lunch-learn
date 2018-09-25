defmodule Abacus do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def add(val) when is_number(val) do
    Agent.update(__MODULE__, fn(state) -> state + val end)
  end

  def sub(val) do
    Agent.update(__MODULE__, fn(state) -> state - val end)
  end

  def get() do
    Agent.get(__MODULE__, fn(state) -> state end)
  end























  # def start_link do
  #   #spawn_link(fn -> loop(0) end)
  #   Task.start_link(fn -> loop(0) end)
  # end

  # defp loop(data) do
  #   IO.puts(data)

  #   receive do
  #     {:add, val} ->
  #       loop(data + val)
  #     {:sub, val} ->
  #       loop(data - val)
  #     {:mul, val} ->
  #       loop(data * val)
  #     {:div, val} ->
  #       loop(data / val)
  #     _ ->
  #       loop(data)
  #   end
  # end
end