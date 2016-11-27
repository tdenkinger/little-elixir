defmodule Cache do
  use GenServer

  @name Cache

  # Public API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, value) do
    GenServer.call(@name, {:write, key, value})
  end

  # Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def ({write:, key, value }, _from, cache) do

  end

end
