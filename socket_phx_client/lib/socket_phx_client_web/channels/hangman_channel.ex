defmodule SocketPhxClientWeb.HangmanChannel do
  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    socket = assign(socket, :game, Hangman.new_game())

    {:ok, socket}
  end

  def handle_in("tally", _, socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)

    {:noreply, socket}
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)

    {:noreply, socket}
  end

  def handle_in("new_game", _, socket) do
    socket = assign(socket, :game, Hangman.new_game())

    {:noreply, socket}
  end
end
