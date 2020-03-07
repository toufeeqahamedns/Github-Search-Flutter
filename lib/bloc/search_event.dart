import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends SearchEvent {
  final String query;

  TextChanged({this.query});
}

class SearchEmptyEvent extends SearchEvent {}

class DisplayUserEvent extends SearchEvent {
  final String userUrl;
  final String repoUrl;

  DisplayUserEvent({this.userUrl, this.repoUrl});
}
