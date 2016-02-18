defmodule RunLengthEncoder do 
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form. 
  "1H1O1R1S1E" => "HORSE" 
  """
  @spec encode(string) :: String.t
  def encode(""), do: ""
  def encode(string) do
    string
      |> String.codepoints
      |> _encode
      |> Enum.reverse
      |> Enum.map_join(fn({char, count}) -> "#{count}#{char}" end)
  end
  defp _encode(list), do: _encode(list, [])
  defp _encode([], acc), do: acc
  defp _encode([h|tail], []), do: _encode(tail, [{h, 1}])
  defp _encode([h|tail], acc=[{last_char, last_char_count}|t_acc]) do
    if last_char == h do
      _encode(tail, [{last_char, last_char_count + 1}|t_acc])
    else
      _encode(tail, [{h, 1}| acc])
    end
  end

  @spec decode(string) :: String.t
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r{(\d+)(\w)}, string)
      |> Enum.map_join(fn([_,count,char]) -> List.duplicate(char, String.to_integer(count)) end) 
  end
end
