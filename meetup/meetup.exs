defmodule Meetup do
  @weekdays %{:monday    => 1, #0
              :tuesday   => 2, #1
              :wednesday => 3, #2
              :thursday  => 4, #3
              :friday    => 5, #4
              :saturday  => 6, #5
              :sunday    => 7} #6
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, :teenth) do
    find_first_weekday_after(year, month, @weekdays[weekday], 13)
  end

  def meetup(year, month, weekday, :first) do
    find_first_weekday_after(year, month, @weekdays[weekday], 1)
  end
  def meetup(year, month, weekday, :second) do
    {year, month, day} = meetup(year, month, weekday, :first)
    {year, month, day + 7}
  end
  def meetup(year, month, weekday, :third) do
    {year, month, day} = meetup(year, month, weekday, :second)
    {year, month, day + 7}
  end
  def meetup(year, month, weekday, :fourth) do
    {year, month, day} = meetup(year, month, weekday, :third)
    {year, month, day + 7}
  end
  def meetup(year, month, weekday, :last) do
    day = :calendar.last_day_of_the_month(year, month)
    dotw = :calendar.day_of_the_week({year, month, day})
    weekday_num = @weekdays[weekday]
    if day == weekday_num do
      {year, month, day}
    else
      day_distance = dotw - weekday_num
      if day_distance < 0 do
        {year, month, day - 7 - day_distance}
      else
        {year, month, day - day_distance} 
      end
    end
  end

  defp find_first_weekday_after(year, month, weekday_num, day) do
    dotw = :calendar.day_of_the_week({year, month, day})
    if dotw == weekday_num do
      {year, month, day}
    else
      day_distance = dotw - weekday_num
      if day_distance < 0 do
        {year, month, day - day_distance}
      else
        {year, month, day + 7 - day_distance} 
      end
    end
  end
end
