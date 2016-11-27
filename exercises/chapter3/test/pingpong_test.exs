defmodule Chapter3.PingPong.Test do
  use ExUnit.Case, async: true

  test "it pings" do
    result = Chapter3.PingPong.shot(:pong)
    assert result == {:ok, "ping"}
  end

  test "it pongs" do
    result = Chapter3.PingPong.shot(:ping)
    assert result == {:ok, "pong"}
  end
end

