import 'package:github_search/api/github_cache.dart';
import 'package:github_search/api/github_client.dart';
import 'package:github_search/models/repos.dart';
import 'package:github_search/models/search_result.dart';
import 'package:github_search/models/user.dart';

class GithubApi {
  final GithubCache cache;
  final GithubClient client;

  GithubApi(this.cache, this.client);

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await client.search(term);
      cache.set(term, result);
      return result;
    }
  }

  Future<User> loadUser(String userUrl) async {
    final result = await client.loadUser(userUrl);
    return result;
  }

  Future<List<Repo>> loadRepo(String repoUrl) async {
    final result = await client.loadRepo(repoUrl);
    return result;
  }
}
