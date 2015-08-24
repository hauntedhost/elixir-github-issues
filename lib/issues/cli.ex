defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and function dispatch
  """

  def run(argv) do
    argv
      |> parse_args
      |> process
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> handle_response
    |> reshape_response
    |> sort_ascending
    |> Enum.take(count)
  end

  def handle_response({:ok, raw_list}), do: raw_list

  def handle_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def reshape_response(raw_list) do
    raw_list
    |> Enum.map(&Enum.into(&1, Map.new))
  end

  def sort_ascending(issues) do
    Enum.sort issues, &(&1.created_at <= &2.created_at)
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help])

    case parse do
      {[help: true], _, _} ->
        :help

      {_, [user, project, count], _} ->
        {user, project, String.to_integer(count)}

      {_, [user, project], _} ->
        {user, project, @default_count}

      _ ->
        :help
    end
  end
end