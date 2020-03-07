class User {
  String avatarUrl;
  String url;
  String reposUrl;
  String name;
  int publicRepos;
  int publicGists;
  int followers;
  int following;

  User({
    this.avatarUrl,
    this.url,
    this.reposUrl,
    this.name,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
  }); 

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatarUrl: json['avatar_url'] as String,
      url: json['url'] as String,
      reposUrl: json['repos_url'] as String,
      name: json['login'] as String,
      publicRepos: json['public_repos'] as int,
      publicGists: json['public_gists'] as int,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );
  }
}
