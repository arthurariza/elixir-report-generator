defmodule GenReport do
  alias GenReport.Parser

  def build(file_name) do
    stream =
      file_name
      |> Parser.parse_file()

    all_hours = all_hours(stream)

    hours_per_month = hours_per_month(stream)

    hours_per_year = hours_per_year(stream)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
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

  defp hours_per_month(stream) do
    stream
    |> Enum.reduce(
      report_acc(),
      fn [dev, hours, _, month, _], report ->
        updated_report =
          report[dev]
          |> Map.update(month, hours, fn existing_value -> existing_value + hours end)

        %{report | dev => updated_report}
      end
    )
  end

  defp hours_per_year(stream) do
    stream
    |> Enum.reduce(
      report_acc(),
      fn [dev, hours, _, _, year], report ->
        updated_report =
          report[dev]
          |> Map.update(year, hours, fn existing_value -> existing_value + hours end)

        %{report | dev => updated_report}
      end
    )
  end

  defp report_acc() do
    %{
      "cleiton" => %{},
      "daniele" => %{},
      "danilo" => %{},
      "diego" => %{},
      "giuliano" => %{},
      "jakeliny" => %{},
      "joseph" => %{},
      "mayk" => %{},
      "rafael" => %{},
      "vinicius" => %{}
    }
  end
end
