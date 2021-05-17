defmodule Issues.TableFormatter do
  def print_table_for_columns(rows, headers) do

  end

  def split_into_columns(rows, headers) do
    Enum.map(headers, fn header -> _split_into_columns_of_header(rows, header) end)
  end

  defp _split_into_columns_of_header(rows, header) do
    Enum.map(rows, fn row -> row[header] end)
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  # def widths_of(columns) do
  #   Enum.map(columns, fn column -> _width_of(column) end)
  # end

  # def _width_of(column) do
  #   List.sort(column, fn a,b -> String.length(a) >= String.length(b) end)
  #   |> List.first
  #   |> String.length
  # end
end
