defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    compare = String.downcase(base)
    candidates
      |> Enum.filter(fn(e) -> anagram(compare, String.downcase(e)) end)
  end

  @spec anagram(String.t, String.t) :: Boolean.t
  defp anagram(base, base), do: false
  defp anagram(base, word) when length(base) != length(word), do: false
  defp anagram(base, word) do
    Enum.sort(String.to_char_list(base)) == Enum.sort(String.to_char_list(word))
  end
end
