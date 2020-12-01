defmodule Aoc1 do
  def main(sum) do
    File.read!("priv/input_day1.txt")
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_parts_of(sum)
  end

  defp find_parts_of(terms, sum) do
    pid = self()

    Enum.each(terms, fn term ->
      Kernel.spawn(fn ->
        summer(terms, term, sum, pid)
      end)
    end)

    receive do
      {a, b, c}-> a*b*c
    end
  end

  defp summer(terms, my_integer, sum, pid) do
    Enum.each(terms, fn term ->
      case calculator(terms, term, sum - my_integer) do
        :nothing -> :ok
        {a, b} -> Kernel.send(pid, {a, b, my_integer})
      end
    end)
  end

  defp calculator([head | _rest], term, sum) when sum == head + term, do: {head, term}
  defp calculator([], _, _), do: :nothing
  defp calculator([_head | rest], term, sum), do: calculator(rest, term, sum)
end
