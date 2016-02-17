defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    Regex.scan(~r/(\p{L}|\d|-)+/u, sentence)
      |> Enum.map(fn(e) -> List.first(e) |> String.downcase end)
      |> Enum.reduce(%{}, fn(word,acc) -> Map.update(acc, word, 1, &(&1 +1)) end) 
  end
end
