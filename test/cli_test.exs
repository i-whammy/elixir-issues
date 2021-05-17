defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_into_ascending_order: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "default count 4 returned if count not given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort_into_ascending_order returns the list sorted by created_at ascending" do
    assert sort_into_ascending_order([
      %{"title" => "a", "created_at" => "2021-01-01"},
      %{"title" => "b", "created_at" => "2020-01-01"},
      %{"title" => "c", "created_at" => "2022-01-01"},
    ]) == [
      %{"title" => "b", "created_at" => "2020-01-01"},
      %{"title" => "a", "created_at" => "2021-01-01"},
      %{"title" => "c", "created_at" => "2022-01-01"},
    ]
  end
end
