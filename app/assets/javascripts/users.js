//$.getJSON( "ajax/test.json", function( data ) {
//  var items = [];
//  $.each( data, function( key, val ) {
//    items.push( "<li id='" + key + "'>" + val + "</li>" );
//  });
//
//  $( "<ul/>", {
//    "class": "my-new-list",
//    html: items.join( "" )
//  }).appendTo( "body" );
//});

var githubUrl = function (user) {
  return "https://api.github.com/users/" + user + "/repos?per_page=100";
}

var displayRepositories = function (user, $element) {
  $.getJSON(githubUrl(user), function (repos) {
    var list = [];
    $.each(repos, function (index, repo) {
      console.log(repo);
      list.push("<li><a href='" + repo.html_url + "'>" + repo.name + "</a></li>");
    });

    var $repoList = $("<ul class='repo-list' />").html(list.join("\n"));
    $element.html($repoList);
  });
}


$(document).ready(function () {
  var $githubRepos = $("#github-repos");

  if ($githubRepos.length !== 0) {
    var user = $githubRepos.attr("data-user");
    displayRepositories(user, $githubRepos);
  }
});
