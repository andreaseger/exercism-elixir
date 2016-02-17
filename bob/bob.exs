defmodule Bob do
  @question "Sure."
  @shouting "Whoa, chill out!"
  @meh "Whatever."
  @silence "Fine. Be that way!"
  def hey(input) do
    cond do
      String.match?(input, ~r/^\s*$/) -> @silence
      String.match?(input, ~r/\p{L}+/u) && String.upcase(input) == input -> @shouting
      String.ends_with?(input, "?") -> @question
      true -> @meh
    end
  end
end
