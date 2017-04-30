defmodule CraftConfTest do
  use ExUnit.Case

  test "async echo" do
    {:ok, pid} = CraftConf.start_link()

    hello_ref = CraftConf.async_send(pid, :hello)
    assert_receive {^hello_ref, :hello}

    hi_ref = CraftConf.async_send(pid, :hi)
    assert_receive {^hi_ref, :hi}
  end

  test "sync echo" do
    {:ok, pid} = CraftConf.start_link()

    assert :hello == CraftConf.sync_send(pid, :hello)
  end

  test "async send timeout" do
    {:ok, pid} = CraftConf.start_link()

    Process.sleep(11)

    refute Process.alive?(pid)
  end

  test "sync send timeout" do
    {:ok, pid} = CraftConf.start_link()

    assert {:error, :timeout} == CraftConf.sync_send(pid, :no_reply)
  end

  test "sync send race condition" do
    {:ok, pid} = CraftConf.start_link()

    Kernel.send(self(), :long_computation)

    assert {:error, :timeout} == CraftConf.sync_send(pid, :no_reply)
  end
end
