defmodule AblyEventStream.MixProject do
  use Mix.Project

  def project do
    [
      app: :ably_event_stream,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AblyEventStream.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.8", path: "local_deps/finch"},
      {:mint, "~> 1.3", path: "local_deps/mint", override: true}
    ]
  end
end
