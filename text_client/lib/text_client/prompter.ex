defmodule TextClient.Prompter do
  def accept_move(game) do
    IO.gets("Your guess: ")
    |> check_guess(game)
  end

  defp check_guess({:error, reason}, _) do
    IO.puts("Game ended: #{reason}")
  end

  defp check_guess(:eof, _) do
    IO.puts("Looks like you gave up")
    exit(:normal)
  end

  defp check_guess(input, game) do
    input = String.trim(input)
    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)
      true ->
        IO.puts "Please enter a single lower case letter"
        accept_move(game)
    end
  end
end
