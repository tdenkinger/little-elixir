defmodule Pooly.ServerTest do
  use ExUnit.Case, async: true
  doctest Pooly.Server

  setup do
    {:ok, server} = Pooly.Server.start_link(:ok,
                                            [mfa: {SampleWorker,
                                                   :start_link, []},
                                            size: 5])
    {:ok, server: server}
  end

  test "Starts the server", %{server: server} do
    # assert Process.alive?(server) == true
  end

end

