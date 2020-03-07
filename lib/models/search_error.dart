class SearchError {
  final String message;

  const SearchError({this.message});

  static SearchError fromJson(dynamic json) {
    return SearchError(
      message: json['message'] as String,
    );
  }
}
