defmodule ArchimedesTest do
  use ExUnit.Case
  @tag :capture_log

  setup do
    Application.stop(:archimedes)
    :ok = Application.start(:archimedes)
  end

  setup do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket} = :gen_tcp.connect('localhost', Archimedes.Application.port(), opts)
    %{socket: socket}
  end

  describe "Archimedes.bind/1" do
    test "serves Fibonacci calculation via TCP", %{socket: socket} do
      assert send_and_recv(socket, "8\r\n") == "21.0000\n"

      Application.stop(:archimedes)
    end
  end

  defp send_and_recv(socket, command) do
    :ok = :gen_tcp.send(socket, command)
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)

    data
  end
end
