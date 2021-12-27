require "test_helper"

class ProjectUpdateHooksControllerTest < ActiveSupport::TestCase
  # We have to use rack-test because string bodies act weird with the default
  # testing integration framework
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "accepts a push event and creates the project" do
    push_body = <<PUSH_BODY
    {
    "ref": "refs/heads/branch-name",
    "before": "0000000000000000000000000000000000000000",
    "after": "6113728f27ae82c7b1a177c8d03f9e96e0adf246",
    "created": true,
    "deleted": false,
    "forced": false,
    "base_ref": "refs/heads/main",
    "compare": "https://github.com/Codertocat/Hello-World/compare/simple-tag",
    "commits": [],
    "head_commit": {
      "id": "6113728f27ae82c7b1a177c8d03f9e96e0adf246",
      "tree_id": "4b825dc642cb6eb9a060e54bf8d69288fbee4904",
      "distinct": true,
      "message": "Adding a .gitignore file",
      "timestamp": "2019-05-15T15:20:41Z",
      "url": "https://github.com/Codertocat/Hello-World/commit/6113728f27ae82c7b1a177c8d03f9e96e0adf246",
      "author": {
        "name": "Codertocat",
        "email": "21031067+Codertocat@users.noreply.github.com",
        "username": "Codertocat"
      },
      "committer": {
        "name": "Codertocat",
        "email": "21031067+Codertocat@users.noreply.github.com",
        "username": "Codertocat"
      },
      "added": [
        ".gitignore"
      ],
      "removed": [],
      "modified": []
    },
    "repository": {
      "id": 186853002,
      "node_id": "MDEwOlJlcG9zaXRvcnkxODY4NTMwMDI=",
      "name": "Hello-World",
      "full_name": "Codertocat/Hello-World",
      "private": false,
      "owner": {
        "name": "Codertocat",
        "email": "21031067+Codertocat@users.noreply.github.com",
        "login": "Codertocat",
        "id": 21031067,
        "node_id": "MDQ6VXNlcjIxMDMxMDY3",
        "avatar_url": "https://avatars1.githubusercontent.com/u/21031067?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/Codertocat",
        "html_url": "https://github.com/Codertocat",
        "followers_url": "https://api.github.com/users/Codertocat/followers",
        "following_url": "https://api.github.com/users/Codertocat/following{/other_user}",
        "gists_url": "https://api.github.com/users/Codertocat/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/Codertocat/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/Codertocat/subscriptions",
        "organizations_url": "https://api.github.com/users/Codertocat/orgs",
        "repos_url": "https://api.github.com/users/Codertocat/repos",
        "events_url": "https://api.github.com/users/Codertocat/events{/privacy}",
        "received_events_url": "https://api.github.com/users/Codertocat/received_events",
        "type": "User",
        "site_admin": false
      },
      "html_url": "https://github.com/Codertocat/Hello-World",
      "description": null,
      "fork": false,
      "url": "https://github.com/Codertocat/Hello-World",
      "forks_url": "https://api.github.com/repos/Codertocat/Hello-World/forks",
      "keys_url": "https://api.github.com/repos/Codertocat/Hello-World/keys{/key_id}",
      "collaborators_url": "https://api.github.com/repos/Codertocat/Hello-World/collaborators{/collaborator}",
      "teams_url": "https://api.github.com/repos/Codertocat/Hello-World/teams",
      "hooks_url": "https://api.github.com/repos/Codertocat/Hello-World/hooks",
      "issue_events_url": "https://api.github.com/repos/Codertocat/Hello-World/issues/events{/number}",
      "events_url": "https://api.github.com/repos/Codertocat/Hello-World/events",
      "assignees_url": "https://api.github.com/repos/Codertocat/Hello-World/assignees{/user}",
      "branches_url": "https://api.github.com/repos/Codertocat/Hello-World/branches{/branch}",
      "tags_url": "https://api.github.com/repos/Codertocat/Hello-World/tags",
      "blobs_url": "https://api.github.com/repos/Codertocat/Hello-World/git/blobs{/sha}",
      "git_tags_url": "https://api.github.com/repos/Codertocat/Hello-World/git/tags{/sha}",
      "git_refs_url": "https://api.github.com/repos/Codertocat/Hello-World/git/refs{/sha}",
      "trees_url": "https://api.github.com/repos/Codertocat/Hello-World/git/trees{/sha}",
      "statuses_url": "https://api.github.com/repos/Codertocat/Hello-World/statuses/{sha}",
      "languages_url": "https://api.github.com/repos/Codertocat/Hello-World/languages",
      "stargazers_url": "https://api.github.com/repos/Codertocat/Hello-World/stargazers",
      "contributors_url": "https://api.github.com/repos/Codertocat/Hello-World/contributors",
      "subscribers_url": "https://api.github.com/repos/Codertocat/Hello-World/subscribers",
      "subscription_url": "https://api.github.com/repos/Codertocat/Hello-World/subscription",
      "commits_url": "https://api.github.com/repos/Codertocat/Hello-World/commits{/sha}",
      "git_commits_url": "https://api.github.com/repos/Codertocat/Hello-World/git/commits{/sha}",
      "comments_url": "https://api.github.com/repos/Codertocat/Hello-World/comments{/number}",
      "issue_comment_url": "https://api.github.com/repos/Codertocat/Hello-World/issues/comments{/number}",
      "contents_url": "https://api.github.com/repos/Codertocat/Hello-World/contents/{+path}",
      "compare_url": "https://api.github.com/repos/Codertocat/Hello-World/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/Codertocat/Hello-World/merges",
      "archive_url": "https://api.github.com/repos/Codertocat/Hello-World/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/Codertocat/Hello-World/downloads",
      "issues_url": "https://api.github.com/repos/Codertocat/Hello-World/issues{/number}",
      "pulls_url": "https://api.github.com/repos/Codertocat/Hello-World/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/Codertocat/Hello-World/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/Codertocat/Hello-World/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/Codertocat/Hello-World/labels{/name}",
      "releases_url": "https://api.github.com/repos/Codertocat/Hello-World/releases{/id}",
      "deployments_url": "https://api.github.com/repos/Codertocat/Hello-World/deployments",
      "created_at": 1557933565,
      "updated_at": "2019-05-15T15:20:41Z",
      "pushed_at": 1557933657,
      "git_url": "git://github.com/Codertocat/Hello-World.git",
      "ssh_url": "git@github.com:Codertocat/Hello-World.git",
      "clone_url": "https://github.com/Codertocat/Hello-World.git",
      "svn_url": "https://github.com/Codertocat/Hello-World",
      "homepage": null,
      "size": 0,
      "stargazers_count": 0,
      "watchers_count": 0,
      "language": "Ruby",
      "has_issues": true,
      "has_projects": true,
      "has_downloads": true,
      "has_wiki": true,
      "has_pages": true,
      "forks_count": 1,
      "mirror_url": null,
      "archived": false,
      "disabled": false,
      "open_issues_count": 2,
      "license": null,
      "forks": 1,
      "open_issues": 2,
      "watchers": 0,
      "default_branch": "master",
      "stargazers": 0,
      "master_branch": "master"
    },
    "pusher": {
      "name": "Codertocat",
      "email": "21031067+Codertocat@users.noreply.github.com"
    },
    "sender": {
      "login": "Codertocat",
      "id": 21031067,
      "node_id": "MDQ6VXNlcjIxMDMxMDY3",
      "avatar_url": "https://avatars1.githubusercontent.com/u/21031067?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/Codertocat",
      "html_url": "https://github.com/Codertocat",
      "followers_url": "https://api.github.com/users/Codertocat/followers",
      "following_url": "https://api.github.com/users/Codertocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/Codertocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/Codertocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/Codertocat/subscriptions",
      "organizations_url": "https://api.github.com/users/Codertocat/orgs",
      "repos_url": "https://api.github.com/users/Codertocat/repos",
      "events_url": "https://api.github.com/users/Codertocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/Codertocat/received_events",
      "type": "User",
      "site_admin": false
    }
  }
PUSH_BODY
    signature = 'sha256=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV['GITHUB_WEBHOOK_SECRET'], push_body)
    push_headers = {
      "X-GitHub-Event" => "push",
      "X-GitHub-Delivery" => "dlkfjoiannaknfiojadsijfe",
      "X-Hub-Signature-256" => signature,
      "Content-Type" => "application/json"
    }
    header "X-GitHub-Event", "push"
    header "X-GitHub-Delivery", "dlkfjoiannaknfiojadsijfe"
    header "X-Hub-Signature-256", signature
    header "Content-Type", "application/json"
    post "/project_update_hooks", push_body
  end
end