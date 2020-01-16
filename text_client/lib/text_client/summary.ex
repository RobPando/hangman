defmodule TextClient.Summary do
  alias TextClient.State

  def display_state_to_user(game = %State{ tally: %{ turns_left: turns_left, letters: letters } }) do
    IO.puts [
      "\n",
      "Word: #{Enum.join(letters, " ")}",
      "\n",
      "You have #{turns_left} turn#{check_plural(turns_left > 1)} left.",
      "\n"
    ]
    game
  end

  def check_plural(true), do: "s"
  def check_plural(false), do: ""
end
