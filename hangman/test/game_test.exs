defmodule GameTest do
  use ExUnit.Case
  doctest Hangman

  alias Hangman.Game

  test "new_game returns game" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "make_move for :won or :lost state returns unchanged game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)

      assert {^game, tally } = Game.make_move(game, "x");
    end
  end

  test "make_move for valid guess" do
    { game, tally } = Game.new_game |> Game.make_move("x")

    assert game.game_state != :already_guessed
    assert MapSet.size(game.used) > 0
  end

  test "make_move for already used letter" do
    { game, tally } = Game.new_game("test") |> Game.make_move("x")
    { game, tally } = Game.make_move(game, "x")

    assert game.game_state == :already_guessed
    assert game.turns_left == 6
  end

  test "a good guess is recognized" do
    { game, tally } = Game.new_game("test") |> Game.make_move("e")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a winning game is recognized" do
    game = Game.new_game("test")
    game = Enum.reduce(game.letters, game, fn letter, game ->
      { game, tally } = Game.make_move(game, letter)
      game
    end)

    assert game.game_state == :won
  end

  test "a bad guess is recognized" do
    { game, tally } = Game.new_game("test")
                      |> Game.make_move("p")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "making 7 bad guess results in a lost" do
    game = Game.new_game("test")
    game = Enum.reduce(~w(q w a r z x v), game, fn letter, game ->
      { game, tally } = Game.make_move(game, letter)
      game
    end)

    assert game.game_state == :lost
    assert game.turns_left == 1
  end
end
