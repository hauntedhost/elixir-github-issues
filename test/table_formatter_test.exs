defmodule TableFormatterTest do
  use ExUnit.Case

  import Issues.TableFormatter,
    only: [column_widths: 2, print_table: 1, print_table: 2]

  test "column_widths" do
    columns = ["number", "created_at", "title"]

    rows = [
      fake_issue(%{"number" => 7, "title" => "Cats", "created_at" => "30"}),
      fake_issue(%{"number" => 5, "title" => "Apples", "created_at" => "10"}),
      fake_issue(%{"number" => 6, "title" => "Bats", "created_at" => "20"})
    ]

    widths = column_widths(rows, columns)

    assert widths["number"] == 8
    assert widths["title"] == 8
    assert widths["created_at"] == 12
  end

  defp fake_issue(issue) do
    default = %{
      "id" => 19583401,
      "title" => "Multiple boards per user",
      "assignee" => nil,
      "body" => "Lorem ipsum",
      "closed_at" => nil,
      "comments" => 1,
      "comments_url" => "https://api.github.com/repos/user/repo/issues/2/comments",
      "created_at" => "2013-09-16T22:22:45Z",
      "events_url" => "https://api.github.com/repos/user/repo/issues/2/events",
      "html_url" => "https://github.com/user/repo/issues/2",
      "labels" => [
        %{
          "color" => "84b6eb",
          "name" => "enhancement",
          "url" => "https://api.github.com/repos/user/repo/labels/enhancement"
        }
      ],
      "labels_url" => "https://api.github.com/repos/user/repo/issues/2/labels{/name}",
      "locked" => false,
      "milestone" => nil,
      "number" => 2,
      "state" => "open",
      "updated_at" => "2014-06-11T15:37:57Z",
      "url" => "https://api.github.com/repos/user/repo/issues/2",
      "user" => %{
        "avatar_url" => "https://avatars.githubusercontent.com/u/3833952?v=3",
        "events_url" => "https://api.github.com/users/user/events{/privacy}",
        "followers_url" => "https://api.github.com/users/user/followers",
        "following_url" => "https://api.github.com/users/user/following{/other_user}",
        "gists_url" => "https://api.github.com/users/user/gists{/gist_id}",
        "gravatar_id" => "",
        "html_url" => "https://github.com/user",
        "id" => 3833952,
        "login" => "user",
        "organizations_url" => "https://api.github.com/users/user/orgs",
        "received_events_url" => "https://api.github.com/users/user/received_events",
        "repos_url" => "https://api.github.com/users/user/repos",
        "site_admin" => false,
        "starred_url" => "https://api.github.com/users/user/starred{/owner}{/repo}",
        "subscriptions_url" => "https://api.github.com/users/user/subscriptions",
        "type" => "User",
        "url" => "https://api.github.com/users/user"
      }
    }
    Map.merge(default, issue)
  end
end
