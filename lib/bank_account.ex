defmodule BankAccount do
  @moduledoc false

  def start do
    await()
  end

  defp await(events \\ []) do
    receive do
      {:deposit, amount, _pid} -> handle_deposit(amount, events)
      {:withdraw, amount, _pid} -> handle_withdrawal(amount, events)
      {:check_balance, pid} -> disclose_balance_to(pid, events)
    end

    await(events)
  end

  defp handle_deposit(deposited_amount, events) do
    handle_new_event({:deposited, deposited_amount}, events)
  end

  defp handle_withdrawal(withdrawn_amount, events) do
    handle_new_event({:withdrawn, withdrawn_amount}, events)
  end

  defp handle_new_event(new_event, events) do
    await(events ++ [new_event])
  end

  defp disclose_balance_to(pid, events) do
    send pid, {:balance, balance_based_on(events), self()}
  end

  defp balance_based_on(events) do
    events |> Enum.reduce(0, &balance_calculator/2)
  end

  defp balance_calculator({:deposited, amount}, balance), do: balance + amount
  defp balance_calculator({:withdrawn, amount}, balance), do: balance - amount
end
