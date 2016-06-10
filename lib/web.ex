defmodule Web do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Web.Endpoint, [], name: Web.Supervisor),
      # Here you could define other workers and supervisors as children
      worker(Web.Versicle, [Web.Versicle]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    r = Supervisor.start_link(children, opts)
    #IO.puts Web.Versicle.suggest(Web.Versicle)
    r
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
