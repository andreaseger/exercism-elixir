defmodule RunLengthEncoder do 
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form. 
  "1H1O1R1S1E" => "HORSE" 
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    Regex.scan(~r{(.)\1*}, string, capture: :first)
      |> List.flatten
      |> Enum.map_join(fn run -> "#{String.length(run)}#{String.first(run)}" end)
  end

  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r{(\d+)(\w)}, string)
      |> Enum.map_join(fn([_,count,char]) -> List.duplicate(char, String.to_integer(count)) end) 
  end
end
