defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) do
    cond do
      search(a,b) -> :sublist
      search(b,a) -> :superlist
      true -> :unequal
    end
  end

  defp search([], _), do: true
  defp search(_, []), do: false
  defp search(a,b) when length(a) > length(b), do: false
  defp search(a, b=[_|b_tail]) do
    starts_with(a,b) || search(a, b_tail)
  end

  defp starts_with([],_), do: true
  defp starts_with([h|a_tail], [h|b_tail]), do: starts_with(a_tail, b_tail)
  defp starts_with(_,_), do: false
end
