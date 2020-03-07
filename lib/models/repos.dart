class Repo {
  String name;

  String url;

  Repo({
    this.name,
    this.url,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'] as String,
      url: json['html_url'] as String,
    );
  }
}
