import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/api/github_api.dart';
import 'package:github_search/bloc/search_event.dart';
import 'package:github_search/bloc/search_state.dart';
import 'package:github_search/models/search_error.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GithubApi githubApi;

  SearchBloc({this.githubApi});

  @override
  Stream<SearchState> transformEvents(Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next) {
    return events
        .debounceTime(
          Duration(milliseconds: 300),
        )
        .switchMap(next);
  }

  @override
  get initialState => InitialState();

  @override
  Stream<SearchState> mapEventToState(event) async* {
    if (event is SearchEmptyEvent) {
      yield SearchEmpty();
    }
    if (event is TextChanged) {
      final String searchTerm = event.query;
      if (searchTerm.isEmpty) {
        yield SearchEmpty();
      } else {
        yield SearchLoading();
        try {
          final results = await githubApi.search(searchTerm);
          yield SearchSuccess(results);
        } catch (error) {
          yield error is SearchError
              ? SearchErrorState(error.message)
              : SearchErrorState('something went wrong');
        }
      }
    }
    if (event is DisplayUserEvent) {
      try {
        yield UserLoading();
        final results = await githubApi.loadUser(event.userUrl);
        final repos = await githubApi.loadRepo(event.repoUrl);
        yield UserRepoLoaded(user: results, repo: repos);
      } catch (error) {
        yield error is SearchError
            ? SearchErrorState(error.message)
            : SearchErrorState('something went wrong');
      }
    }
  }
}
