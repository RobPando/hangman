defmodule PhxClientWeb.HangmanView do
  use PhxClientWeb, :view

  @responses %{
    :won => {:success, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:success, "Good guess!"},
    :bad_guess => {:warning, "Bad guess!"},
    :already_guessed => { :info, "You already guessed that"},
  }

  def turn(turns_left, target) when turns_left <= target  do
    "opacity: 1"
  end

  def turn(_turns_left, _target) do
    "opacity: 0.1"
  end

  def game_over?(game_state) do
    game_state in [:won, :lost]
  end

  def new_game_button(conn, text) do
    button(text, to: Routes.hangman_path(conn, :new))
  end

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: ""
  defp alert({class, message}) do
    """
      <div class="alert alert-#{class}">
        #{message}
      </div>
    """
    |> raw()
  end
end
