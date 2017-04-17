defmodule PongTest do
  use ExUnit.Case

  test "it responds to a ping with a pong" do
    pong_pid = spawn_link(Pong, :start, [])
    send pong_pid, {:ping, self()}

    assert_receive {:pong, ^pong_pid}
  end

  test "it responds to two pings with two pongs" do
    pong_pid = spawn_link(Pong, :start, [])
    send pong_pid, {:ping, self()}
    send pong_pid, {:ping, self()}

    assert_receive {:pong, ^pong_pid}
    assert_receive {:pong, ^pong_pid}
  end

  test "it will only respond to up to three pings" do
    pong_pid = spawn_link(Pong, :start, [])
    send pong_pid, {:ping, self()}
    send pong_pid, {:ping, self()}
    send pong_pid, {:ping, self()}
    send pong_pid, {:ping, self()}

    assert_receive {:pong, ^pong_pid}
    assert_receive {:pong, ^pong_pid}
    assert_receive {:pong, ^pong_pid}
    refute_receive {:pong, ^pong_pid}
  end
end
