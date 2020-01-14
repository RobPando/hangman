defmodule TextClient.Summary do
  alias TextClient.State

  def display_state_to_user(game = %State{ tally: %{ turns_left: turns_left, letters: letters } }) do
    IO.puts [
      "\n",
      "Word: #{Enum.join(letters, " ")}",
      "\n",
      "You have #{turns_left} turn#{turns_left > 1 && "s"} left.",
      "\n"
    ]
    game
  end
end
