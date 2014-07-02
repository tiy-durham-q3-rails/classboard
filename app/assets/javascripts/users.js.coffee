githubUrl = (user) ->
  "https://api.github.com/users/" + user + "/repos?per_page=100"

useGithubRepos = (user, fn) ->
  $.getJSON githubUrl(user), fn

displayRepositories = (user, $element) ->
  useGithubRepos user, (repos) ->
    list = []
    makeLi = (repo) ->
      "<li><a href='#{repo.html_url}'>#{repo.name}</a></li>"
    list = (makeLi(repo) for repo in repos)

    $repoList = $("<ul class='repo-list' />").html(list.join("\n"))
    $element.html $repoList

window.selectRepositories = (user, $input) ->
  useGithubRepos user, (repos) ->
    list = []
    makeOption = (repo) ->
      "<option value='#{repo.html_url}'>#{repo.name}</option>"
    list = (makeOption(repo) for repo in repos)
    list.unshift("<option value=''>No repository</option>")

    id = $input.attr('id');
    name = $input.attr('name')
    value = $input.attr('value')
    $select = $("<select class='select' id='#{id}' name='#{name}' />")
    $select.html(list.join("\n")).val(value).replaceAll($input)

window.currentUserInfo = ->
  $("meta[name=current_user]").data()

$(document).ready ->
  $githubRepos = $("#github-repos")
  if $githubRepos.length > 0
    user = $githubRepos.attr("data-user")
    displayRepositories user, $githubRepos

  $helpRequestRepo = $("#help_request_repo");
  if $helpRequestRepo.length > 0
    selectRepositories currentUserInfo().github, $helpRequestRepo
