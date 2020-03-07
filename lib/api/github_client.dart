import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:github_search/models/repos.dart';
import 'package:github_search/models/search_error.dart';
import 'package:github_search/models/search_result.dart';
import 'package:github_search/models/user.dart';
import 'package:http/http.dart' as http;

class GithubClient {
  final String baseUrl;
  final http.Client httpClient;

  GithubClient({
    http.Client httpClient,
    this.baseUrl = "https://api.github.com/search/users?q=",
  }) : this.httpClient = httpClient ?? http.Client();

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$term"));
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw SearchError.fromJson(results);
    }
  }

  Future<User> loadUser(String url) async {
    final response = await httpClient.get(Uri.parse(url));
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(results);
    } else {
      throw SearchError.fromJson(results);
    }
  }

  Future<List<Repo>> loadRepo(String url) async {
    final response = await httpClient.get(Uri.parse(url));
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Repo>((json) => Repo.fromJson(json)).toList();
      
    } else {
      throw SearchError.fromJson(results);
    }
  }

  List<Repo> parseRepo(dynamic responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Repo>((json) => Repo.fromJson(json)).toList();
  }
}