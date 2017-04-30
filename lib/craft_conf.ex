defmodule CraftConf do
  @moduledoc false

  @loop_timeout 10
  @sync_send_timeout 200

  def start_link do
    pid = spawn_link(&loop/0)
    {:ok, pid}
  end

  def async_send(pid, message) do
    ref = make_ref()
    payload = {ref, self(), message}

    Kernel.send(pid, payload)

    ref
  end

  def sync_send(pid, message) do
    ref = async_send(pid, message)

    receive do
      {^ref, message} -> message
    after
      @sync_send_timeout -> {:error, :timeout}
    end
  end

  defp loop do
    receive do
      {_ref, _caller, :no_reply} ->
        loop()
      {ref, caller, :long_computation} ->
        Process.sleep(@sync_send_timeout + 1)
        Kernel.send(caller, {ref, :long_computation})
      {ref, caller, message} when is_pid(caller) ->
        Kernel.send(caller, {ref, message})
        loop()
    after
      @loop_timeout -> exit(:normal)
    end
  end
end
