defmodule TextClient.Player do
  alias TextClient.{Prompter, State, Summary}

  def play(%State{ tally: %{ game_state: :won } }) do
    exit_with_message("You WON!")
  end

  def play(%State{ tally: %{ game_state: :lost } }) do
    exit_with_message("Sorry, you lost!")
  end

  def play(game = %State{ tally: %{ game_state: :good_guess } }) do
    continue_with_message(game, "Noice!")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess } }) do
    continue_with_message(game, "WRONG!, try another one.")
  end

  def play(game = %State{ tally: %{ game_state: :already_guessed } }) do
    continue_with_message(game, "You already guessed that.")
  end

  def play(game) do
    continue_playing(game)
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue_playing(game)
  end

  defp continue_playing(game) do
    game
    |> Summary.display_state_to_user()
    |> Prompter.accept_move()
    |> make_move()
    |> play()
  end

  defp make_move(game) do
    tally = Hangman.make_move(game.game_service, game.guess)
    %State{game | tally: tally}
  end
end
