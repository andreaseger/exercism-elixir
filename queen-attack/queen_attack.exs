defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new(nil | list) :: Queens.t()
  def new do
    %Queens{black: {7,3}, white: {0,3}}
  end
  def new([white: pos_white, black: pos_black]) do
    if pos_black == pos_white do
      raise ArgumentError
    else
      %Queens{black: pos_black, white: pos_white}
    end
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    0..7
      |> Enum.map_join("\n", fn(x) -> print_line(x, queens) end)
  end

  defp print_line(x, %Queens{black: {bx,by}, white: {wx, wy}}) do
    0..7
      |> Enum.map_join(" ", fn(y) ->
          cond do
            (bx == x && by == y) -> "B"
            (wx == x && wy == y) -> "W"
            true -> "_"
          end
        end)
  end


  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {bx,by}, white: {wx,wy}}) do
    (bx == wx) || (by == wy) || (abs(bx - wx) == abs(by - wy))
  end
end
