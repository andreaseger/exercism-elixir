defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    String.graphemes(str)
      |> balanced?([])
  end

  defp balanced?([],[]), do: true
  defp balanced?([],_), do: false
  defp balanced?([c|rest], stack) when c in ["{", "[", "("], do: balanced?(rest, [c|stack])
  defp balanced?(["]"|rest], ["["|stack]), do: balanced?(rest, stack)
  defp balanced?([")"|rest], ["("|stack]), do: balanced?(rest, stack)
  defp balanced?(["}"|rest], ["{"|stack]), do: balanced?(rest, stack)
  defp balanced?([c|_rest], _stack) when c in ["}","]",")"], do: false
  defp balanced?([_|rest], stack), do: balanced?(rest, stack)
end
