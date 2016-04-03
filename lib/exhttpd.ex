defmodule Exhttpd do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # `start_server` function is used to spawn the worker process
      worker(__MODULE__, [], function: :start_server)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exhttpd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Start Cowboy server and use our router
    def start_server do
      { :ok, _ } = Plug.Adapters.Cowboy.http Exhttpd.Router, []
    end
end
