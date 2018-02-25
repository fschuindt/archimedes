defmodule Archimedes.Application do
  use Application

  @moduledoc false

  def start(_type, _args) do
    server = fn -> port() |> Archimedes.bind() end

    children = [
      {Task.Supervisor, name: Archimedes.TaskSupervisor},
      Supervisor.child_spec({Task, server}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Archimedes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def port do
    System.get_env("PORT")
    |> Integer.parse()
    |> elem(0)
  end
end
