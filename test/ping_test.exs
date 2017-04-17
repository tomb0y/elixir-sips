defmodule PingTest do
  use ExUnit.Case

  test "it responds to a pong with a ping" do
    ping_pid = spawn_link(Ping, :start, [])
    send ping_pid, {:pong, self()}

    assert_receive {:ping, ^ping_pid}
  end

  test "it responds to two pongs with two pings" do
    ping_pid = spawn_link(Ping, :start, [])
    send ping_pid, {:pong, self()}
    send ping_pid, {:pong, self()}

    assert_receive {:ping, ^ping_pid}
    assert_receive {:ping, ^ping_pid}
  end
end
