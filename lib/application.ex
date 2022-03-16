defmodule AblyEventStream.Application do
  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Playground.Supervisor]

    Supervisor.start_link(children(), opts)
  end

  def children do
    [
      {Finch, name: AblyEventStream.HTTP}
    ]
  end
end
