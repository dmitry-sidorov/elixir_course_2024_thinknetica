defmodule TramFsmTest do
  use ExUnit.Case
  doctest TramFsm

  transitions = TramFsm.transition_scheme()
  all_transitions = transitions |> Enum.map(fn %{name: name} -> name end) |> Enum.uniq()

  for transition <- transitions do
    @tag transition: transition
    test "Test transition #{transition.from} -> #{transition.to}", %{
      transition: %Transition{name: transition_name, from: from, to: to}
    } do
      {:ok, pid} = TramFsm.start_link(%{tram_state: from})
      {:info, %{current_state: current_state}} = TramFsm.info(pid)
      {:ok, _} = TramFsm.transition(pid, transition_name)
      {:info, %{current_state: new_state}} = TramFsm.info(pid)

      assert current_state == from, "should start from current state"
      assert new_state == to, "should apply transition"
    end
  end

  for transition <- transitions do
    @tag transition: transition
    @tag all_transitions: all_transitions
    test "Test unapplicable transition #{transition.from} -> #{transition.to}", %{
      transition: %Transition{from: from},
      all_transitions: all_transitions
    } do
      {:ok, pid} = TramFsm.start_link(%{tram_state: from})
      {:info, %{available_transitions: available_transitions}} = TramFsm.info(pid)
      unapplicable_transitions = all_transitions -- available_transitions

      for unapplicable_transition <- unapplicable_transitions do
        {:error, error_message, _info} =
          TramFsm.transition(pid, unapplicable_transition)

        {:info, %{current_state: current_state}} = TramFsm.info(pid)

        assert current_state == from
        assert error_message == "transition #{unapplicable_transition} is unapplicable"
      end
    end
  end

  invalid_transitions = StreamData.string(?a..?z, min_length: 2, max_length: 50) |> Enum.take(100)
  current_transition = transitions |> Enum.fetch!(1)

  for invalid_transition <- invalid_transitions do
    @tag invalid_transition: invalid_transition
    @tag current_transition: current_transition
    test "Test invalid transition #{invalid_transition}", %{
      invalid_transition: invalid_transition,
      current_transition: %Transition{name: transition_name, from: from}
    } do
      {:ok, pid} = TramFsm.start_link(%{tram_state: from})

      {:error, message, _info} = TramFsm.transition(pid, invalid_transition)
      {:info, %{current_state: new_state}} = TramFsm.info(pid)

      assert new_state == from, "transition #{transition_name} should not change state"
      assert message == "transition #{invalid_transition} doesn't exist"
    end
  end
end
