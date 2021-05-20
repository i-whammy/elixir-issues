defmodule Issues.TableFormatter do
  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths = widths_of(data_by_columns),
         format = format_for(column_widths)
    do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(data_by_columns, format)
    end

  end

  @doc """
  Given a list of rows, where each row contains a keyed list of columns,
  return a list containing lists of the data in each column.
  The 'headers' parameter contains the list of columns to extract.

  ## example
    iex> list = [Enum.into([{"a", "1"}, {"b", "2"}, {"c", "3"}], %{}),
    ...>         Enum.into([{"a", "4"}, {"b", "5"}, {"c", "6"}], %{})]
    iex> Issues.TableFormatter.split_into_columns(list, ["a", "b", "c"])
    [ ["1", "4"], ["2", "5"], ["3", "6"]]
  """
  def split_into_columns(rows, headers) do
    Enum.map(headers, fn header -> _split_into_columns_of_header(rows, header) end)
  end

  defp _split_into_columns_of_header(rows, header) do
    Enum.map(rows, fn row -> printable(row[header]) end)
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(columns) do
    for column <- columns, do: column |> Enum.map(&String.length/1) |> Enum.max
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn a -> "~-#{a}s" end) <> "~n"
  end

  def separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> String.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
