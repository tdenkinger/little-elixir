defmodule Chapter3.PingPong do
  def shot(:pong) do
    {:ok, "ping"}
  end

  def shot(:ping) do
    {:ok, "pong"}
  end
end

