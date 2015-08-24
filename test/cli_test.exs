defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1, sort_ascending: 1]

  test ":help returned by option parsing with -h and --help" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "count is default if two values given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort ascending orders correctly" do
    fake_issues = ~w[c a b] |> Enum.map &(fake_issue(%{ "created_at" => &1}))
    sorted_issues = sort_ascending(fake_issues)
    assert (sorted_issues |> Enum.map &(&1["created_at"])) == ~w[a b c]
  end

  defp fake_issue(issue) do
    default = %{"title" => "Example"}
    Map.merge(default, issue)
  end
end
