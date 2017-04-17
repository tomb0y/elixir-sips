defmodule BankAccountTest do
  use ExUnit.Case

  describe "balance" do
    test "it starts off with 0" do
      account = spawn_link(BankAccount, :start, [])

      verify_balance_is 0, account
    end

    test "it is incremented by the amount of a deposit" do
      account = spawn_link(BankAccount, :start, [])

      send account, {:deposit, 42, self()}

      verify_balance_is 42, account
    end

    test "it is decremented by the amount of a withdrawal" do
      account = spawn_link(BankAccount, :start, [])

      send account, {:deposit, 42, self()}
      send account, {:withdraw, 32, self()}

      verify_balance_is 10, account
    end
  end


  defp verify_balance_is(expected_balance, account) do
    send account, {:check_balance, self()}

    assert_receive {:balance, ^expected_balance, ^account}
  end
end
