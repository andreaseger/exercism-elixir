defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

	def from(datetime) do
    datetime
      |> :calendar.datetime_to_gregorian_seconds
      |> +(1.0e9)
      |> round
      |> :calendar.gregorian_seconds_to_datetime
	end
end
