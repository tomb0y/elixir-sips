defmodule MiniStringFuck do
  @moduledoc false

  def execute(command), do: to_string(do_execute(command, 0, []))

  defp do_execute("", _state, output) do
    output
  end
  defp do_execute("." <> command, state, output) do
    do_execute(command, state, output ++ [state])
  end
  defp do_execute("+" <> command, state, output) do
    do_execute(command, next_state(state), output)
  end
  defp do_execute(<<_::bytes-size(1)>> <> command, state, output) do
    do_execute(command, state, output)
  end

  defp next_state(255), do: 0
  defp next_state(state), do: state + 1
end
