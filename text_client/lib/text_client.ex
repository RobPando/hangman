defmodule TextClient do
  alias TextClient.Interact

  defdelegate start(), to: Interact
end
