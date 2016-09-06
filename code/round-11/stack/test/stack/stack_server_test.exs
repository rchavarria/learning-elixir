defmodule Stack.ServerTest do
  use ExUnit.Case

  test "Pops the first element" do
    first = Stack.Server.pop
    assert first == 1
  end

  test "Pushes a value correctly" do
    assert Stack.Server.push(12) == :ok
  end

  test "Pops what the last pushed value" do
    value = 32
    Stack.Server.push value
    assert Stack.Server.pop == value
  end

end
