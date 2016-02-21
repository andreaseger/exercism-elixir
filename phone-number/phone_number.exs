defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    parts = raw |> clean_number |> extract_number
    cond do
      List.first(parts) == "1" || List.first(parts) == ""
        -> parts |> List.delete_at(0) |> Enum.join
      true
        -> "0000000000"
    end
  end

  defp clean_number(raw) do
    String.replace(raw, ~r{\s|\.|-|\(|\)}, "")
  end

  defp extract_number(number) do
    Regex.scan(~r/(\d?)(\d{3})(\d{3})(\d{4})$/, number, capture: :all_but_first)
      |> List.flatten
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    Regex.scan(~r/^(\d{3})\d+/, number(raw), capture: :all_but_first)
      |> List.flatten
      |> List.first
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    [area|[exchange|subscriber]] = Regex.scan(~r/(\d{3})(\d{3})(\d{4})/, number(raw), capture: :all_but_first) |> List.flatten
    "(#{area}) #{exchange}-#{List.first(subscriber)}"
  end
end
