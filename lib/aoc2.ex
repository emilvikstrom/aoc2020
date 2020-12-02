defmodule Aoc2 do
  def main() do
    File.read!("priv/input_day2.txt")
    |> String.split("\n")
    |> Enum.map(&parse_password_policies/1)
  end

  defp parse_password_policies(password_policies) do
    case String.split(password_policies, " ") do
      [range, char, password] ->
        [min, max] = String.split(range, "-")

        %{
          min: String.to_integer(min),
          max: String.to_integer(max),
          char: String.trim(char, ":"),
          password: password
        }

      _ ->
        []
    end
  end
end
