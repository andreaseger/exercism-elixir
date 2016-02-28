defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

	def from(datetime) do
    seconds = :calendar.datetime_to_gregorian_seconds(datetime)
    1.0e9 + seconds |> round |> :calendar.gregorian_seconds_to_datetime
	end
end
