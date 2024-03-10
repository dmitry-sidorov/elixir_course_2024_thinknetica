defmodule TramFsmTest do
  use ExUnit.Case
  doctest TramFsm

  {:ok, pid} = TramFsm.start_link()

  [head | tail] = TramFsm.transition_scheme() |> Map.to_list()
  transitions = tail ++ [head]
  IO.inspect(transitions)

  for transition <- transitions do
    {transition_name, payload} = transition

    @tag transition: transition
    @tag pid: pid
    test "Test transition #{transition_name}", %{
      transition: {current_transition, %{to: to}},
      pid: pid
    } do
      IO.inspect(to)

      {:transition, data} = TramFsm.transition(pid, to)
      IO.inspect(data)

      assert true
    end
  end

  # end
end
