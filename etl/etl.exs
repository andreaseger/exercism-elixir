defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Map) :: map()
  def transform(input) do
    Enum.reduce(input, %{}, fn({key, values}, acc) ->
      Enum.reduce(values, acc, fn(e, acc) -> Map.put(acc, String.downcase(e), key) end)
    end)
  end
end
