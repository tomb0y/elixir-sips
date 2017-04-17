defmodule Pong do
  @moduledoc false

  def start do
    await()
  end

  defp await(ping_count \\ 0)
  defp await(ping_count) when ping_count >= 3, do: :nothing
  defp await(ping_count) when ping_count < 3 do
    receive do
      {:ping, pid} -> send pid, {:pong, self()}
    end

    await(ping_count + 1)
  end
end
