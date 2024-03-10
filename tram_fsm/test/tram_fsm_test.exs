defmodule TramFsmTest do
  use ExUnit.Case
  doctest TramFsm

  transitions = TramFsm.transition_scheme() |> Map.to_list()

  for {transition_name, transition_data} <- transitions do
    @tag transition_name: transition_name
    @tag transition_data: transition_data
    test "Test transition #{transition_name}", %{
      transition_name: transition_name,
      transition_data: %{from: from, to: to}
    } do
      {:ok, pid} = TramFsm.start_link(%{tram_state: from})
      {:info, %{current_state: current_state}} = TramFsm.info(pid)
      {:ok, _} = TramFsm.transition(pid, transition_name)
      {:info, %{current_state: new_state}} = TramFsm.info(pid)

      assert current_state == from, "should start from current state"
      assert new_state == to, "should apply transition"
    end
  end

  for {transition_name, transition_data} <- transitions do
    @tag transition_name: transition_name
    @tag transition_data: transition_data
    test "Test same transition applied twice #{transition_name}", %{
      transition_name: transition_name,
      transition_data: %{to: to}
    } do
      {:ok, pid} = TramFsm.start_link(%{tram_state: to})
      {:info, %{current_state: current_state}} = TramFsm.info(pid)
      assert current_state == to, "should start from current state"

      {:error, warning} = TramFsm.transition(pid, transition_name)
      {:info, %{current_state: new_state}} = TramFsm.info(pid)

      assert new_state == to, "should not change state"
      assert warning == "tram is already in required state #{to}"
    end
  end
end
