class SearchResult {
  final List<Items> items;

  const SearchResult({this.items});

  static SearchResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((dynamic item) => Items.fromJson(item as Map<String, dynamic>))
        .toList();

    return SearchResult(items: items);
  }
}

class Items {
  String login;
  String avatarUrl;
  String url;
  String reposUrl;

  Items({
    this.login,
    this.avatarUrl,
    this.url,
    this.reposUrl,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      url: json['url'] as String,
      reposUrl: json['repos_url'] as String,
    );
  }
}
