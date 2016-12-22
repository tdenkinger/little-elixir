defmodule SampleWorkerTest do
  use ExUnit.Case, async: true
  doctest SampleWorker

  setup do
    {:ok, sample} = SampleWorker.start_link(:ok)
    {:ok, sample: sample}
  end

  test "Starts the server", %{sample: sample} do
    assert Process.alive?(sample) == true
  end

  test "Stops the server", %{sample: sample} do
    SampleWorker.stop(sample)
    assert Process.alive?(sample) == false
  end
end

