defmodule Pooly.WorkerSupervisorTest do
  use ExUnit.Case, async: true
  doctest Pooly.WorkerSupervisor

  describe "WorkerSupervisor" do
    test "has an initial state" do
      {:ok, sup} = Pooly.WorkerSupervisor.start_link({:ok, :ok, []})
      assert sup != nil
    end
  end
end

