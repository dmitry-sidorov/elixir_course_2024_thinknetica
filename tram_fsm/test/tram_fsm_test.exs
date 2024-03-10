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

  invalid_transitions = StreamData.string(?a..?z, min_length: 2, max_length: 50) |> Enum.take(100)
  current_transition = transitions |> Enum.fetch!(1)

  for invalid_transition <- invalid_transitions do
    @tag invalid_transition: invalid_transition
    @tag current_transition: current_transition
    test "Test invalid transition #{invalid_transition}", %{
      invalid_transition: invalid_transition,
      current_transition: current_transition
    } do
      {transition, %{from: from}} = current_transition
      {:ok, pid} = TramFsm.start_link(%{tram_state: from})

      {:error, message, info} = TramFsm.transition(pid, invalid_transition)
      {:info, %{current_state: new_state}} = TramFsm.info(pid)

      assert new_state == from, "should not change state"
      assert message == "transition doesn't exist"
      assert info == %{current_state: from, available_transitions: [transition]}
    end
  end
end
