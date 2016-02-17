defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/\b\p{L}|\p{Lu}/u, string)
      |> Enum.join
      |> String.upcase
  end
end
