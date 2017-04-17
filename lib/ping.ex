defmodule Ping do
  @moduledoc false

  def start do
    await()
  end

  defp await do
    receive do
      {:pong, pid} -> send pid, {:ping, self()}
    end

    await()
  end
end
