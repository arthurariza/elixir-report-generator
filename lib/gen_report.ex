defmodule GenReport do
  alias GenReport.Parser

  def build(file_name) do
    stream =
      file_name
      |> Parser.parse_file()

    all_hours = all_hours(stream)

    %{all_hours: all_hours}
  end

  def build() do
    {:error, "Please, provide a file name"}
  end

  defp all_hours(stream) do
    stream
    |> Enum.reduce(
      %{},
      fn [dev, hours, _, _, _], report ->
        worked_hours = report[dev] || 0

        Map.put(report, dev, worked_hours + hours)
      end
    )
  end
end
