defmodule Metex.WorkerTest do
  use ExUnit.Case, async: true
  doctest Metex.Worker

  alias Metex.Worker

  test "Does not get an error getting the temperature" do
    wx = Worker.temperature_of("Chicago")
    assert wx != "Chicago not found"
  end
end

