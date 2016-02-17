defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    _count(l,0)
  end

  def _count([],acc), do: acc
  def _count([head|tail], acc) do
    _count(tail, acc + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    _reverse(l, [])
  end

  # _rev([1,2,3],[])
  #   _rev([2,3],[1])
  #     _rev([1],[2,1])
  #       _rev([],[3,2,1])
  def _reverse([], acc), do: acc
  def _reverse([h|t], acc) do
    _reverse(t, [h|acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l |> reverse |> _map(f,[])
  end

  def _map([],_f,acc), do: acc
  def _map([h|t], f, acc) do
    _map(t, f, [f.(h)|acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l |> reverse |> _filter(f, [])
  end

  def _filter([], _f, acc), do: acc
  def _filter([h|t], f, acc) do
    if f.(h) do
      _filter(t, f, [h|acc])
    else
      _filter(t, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h,acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> _reverse(b)
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) do
    append(h, concat(t))
  end
end
