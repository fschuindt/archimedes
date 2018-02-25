require Logger

defmodule Archimedes do
  alias Archimedes.FibonacciCalculus
  @tcp [:binary, packet: :line, active: false, reuseaddr: true]

  def bind(port) do
    {:ok, socket} = :gen_tcp.listen(port, @tcp)
    Logger.info("Listening in TCP port #{port}.")

    connect(socket)
  end

  defp connect(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Archimedes.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)

    Logger.info("Connection opened.")
    connect(socket)
  end

  defp serve(client) do
    client
    |> read_input()
    |> respond_fibonacci(client)

    serve(client)
  end

  defp read_input(socket) do
    {:ok, input} = :gen_tcp.recv(socket, 0)

    Logger.info("Received input: #{String.trim(input)}.")
    input
  end

  defp respond_fibonacci(input, socket) do
    result = binary_fibonacci_of(input)

    :gen_tcp.send(socket, result <> "\n")
    Logger.info("Sent result: #{result}.")
  end

  defp binary_fibonacci_of(input) do
    Integer.parse(input)
    |> elem(0)
    |> FibonacciCalculus.of()
    |> :erlang.float_to_binary(decimals: 4)
  end
end
