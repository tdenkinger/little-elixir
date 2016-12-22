defmodule Pooly.Server do
  use GenServer

  defmodule State do
    defstruct sup: nil, size: nil, mfa: nil, workers: nil, workers_sup: nil
  end

  # API

  def start_link(sup, pool_config) do
    GenServer.start_link(__MODULE__, [sup, pool_config], name: __MODULE__)
  end

  # Callbacks

  def init([sup, pool_config]) when is_pid(sup) do
    init(pool_config, %State{sup: sup})
  end

  def init([{:mfa, mfa}   | rest], state), do: init(rest, %{state | mfa: mfa})
  def init([{:size, size} | rest], state), do: init(rest, %{state | size: size})
  def init([_             | rest], state), do: init(rest, state)

  def init([], state) do
    send(self, :start_worker_supervisor)
    {:ok, state}
  end

  def handle_info(:start_worker_supervisor,
                  state = %{sup: sup, mfa: mfa, size: size}) do
    {:ok, worker_sup} = Supervisor.start_child(sup, supervisor_spec(mfa))
    workers = prepopulate(size, worker_sup)
    {:noreply, %{state | worker_sup: worker_sup, workers: workers}}
  end

  # Private helpers

  defp supervisor_spec(mfa) do
    opts = [restart: :temporary]
    supervisor(Pooly.WorkerSupervisor, [mfa], opts)
  end

  defp prepopulate(size, sup) do
    prepopulate(size, sup, [])
  end

  defp prepopulate(size, _sup, workers) when size < 1, do: workers

  defp prepopulate(size, sup, workers) do
    prepopulate(size-1, sup, [new_worker(sup) | workers])
  end

  defp new_worker(sup) do
    {:ok, worker} = Supervisor.start_child(sup, [[]])
    worker
  end

end

