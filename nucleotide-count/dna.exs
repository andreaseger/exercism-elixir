defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    histogram(strand)[nucleotide] || 0
  end
  def count(_,_), do: raise ArgumentError


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @base_histogram %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
  @spec histogram([char]) :: Map
  def histogram(strand) do
    if Enum.all?(strand, fn(e) -> Map.has_key?(@base_histogram, e) end) do
      strand |> Enum.reduce(@base_histogram, fn(e,acc) -> Map.update(acc, e, 1, &(&1 +1)) end)
    else
      raise ArgumentError
    end

  end
end
