import 'package:equatable/equatable.dart';
import 'package:github_search/models/repos.dart';
import 'package:github_search/models/search_result.dart';
import 'package:github_search/models/user.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class InitialState extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchResult items;

  const SearchSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchSuccess { items: $items}';
}

class SearchErrorState extends SearchState {
  final String error;

  const SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class DisplayUser extends SearchState {}

class UserLoading extends SearchState {}

class UserRepoLoaded extends SearchState {
  final User user;
  final List<Repo> repo;

  const UserRepoLoaded({this.user, this.repo});
}
