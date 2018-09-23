defmodule SecondDayExample do

  # [1, 2, 3]
  # {}
  # fn(1, {}) = {1}
  # fn(2, {1}) = {1, 2}
  # fn(3, {1, 2}) = {1, 2, 3}
  defp to_tuple(l) when is_list(l) do
    Enum.reduce(l, {}, 
      fn(v, acc) -> Tuple.insert_at(acc, tuple_size(acc), v) end)
  end

  @doc """
  Doubles a numeric value and returns it.

  ## Examples
    iex> SecondDayExample.double(2)
    4
    iex> SecondDayExample.double(2.1)
    4.2
    iex> SecondDayExample.double(5)
    10
  """
  def double(n) when is_integer(n) or is_float(n) do
    n * 2
  end

  def double(s) when is_bitstring(s) do
    s <> s
  end

  def double(l) when is_list(l) do
    # [1,2,3]
    # [1,2, "a"]
    # [[1,2],[2,3]]
    Enum.map(l, fn(v) -> double(v) end)
  end

  def double(t) when is_tuple(t) do
    # {1, 2, 3}
    t
    |> Tuple.to_list
    |> double
    |> to_tuple
  end

  def double(m) when is_map(m) do
    # %{a: 1, b: 2, c: 3}
    # %{"973-534-9899" => "Mike Arlington"}

    # %{word:1, b: 2, 3 => "whatever"}

    Enum.map(m, fn({k,v}) -> {k, double(v)} end)
  end

  def double(_) do
    "Sorry Dave, I don't know how to do that."
  end

  def print_double_of_this(input) do
    input
    |> double
    |> IO.inspect
  end
end
