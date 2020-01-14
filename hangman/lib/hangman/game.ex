defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{ letters: String.codepoints(word) }
  end

  def new_game() do
    %Hangman.Game{ letters: Dictionary.random_word() |> String.codepoints() }
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    validate_move(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: MapSet.to_list(game.used)
    }
  end

  defp validate_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_guessed)
  end

  defp validate_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters,guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
    |> MapSet.subset?(game.used)
    |> did_win()
    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{ turns_left: 1 }, _bad_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(game = %{ turns_left: turns_left }, _bad_guess) do
    %{ game | turns_left: turns_left - 1, game_state: :bad_guess }
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, Enum.member?(used, letter)) end)
  end

  defp reveal_letter(letter, true), do: letter
  defp reveal_letter(_letter, _not_guessed), do: "_"

  defp did_win(true), do: :won
  defp did_win(false), do: :good_guess

  defp return_with_tally(game), do: { game, tally(game) }
end
