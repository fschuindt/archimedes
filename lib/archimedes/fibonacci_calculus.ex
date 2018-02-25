defmodule Archimedes.FibonacciCalculus do
  @moduledoc """
  A Fibonacci implementation based on calculations other than
  iterations.
  """

  @golden_n :math.sqrt(5)

  @doc ~S"""
  Calculates a aproximation for the `n` term position of
  the Fibonacci sequence, being `n` a given integer.

  ## Examples

      iex> Archimedes.FibonacciCalculus.of(8)
      21.000000000000004

      iex> Archimedes.FibonacciCalculus.of(8) |> Kernel.trunc
      21
  """
  def of(n) do
    (x_of(n) - y_of(n)) / @golden_n
  end

  defp x_of(n) do
    :math.pow((1 + @golden_n) / 2, n)
  end

  defp y_of(n) do
    :math.pow((1 - @golden_n) / 2, n)
  end
end
