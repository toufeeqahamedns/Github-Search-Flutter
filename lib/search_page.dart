import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/bloc/search_bloc.dart';
import 'package:github_search/bloc/search_event.dart';
import 'package:github_search/bloc/search_state.dart';
import 'package:github_search/models/search_result.dart';

class SearchPage extends SearchDelegate<SearchResult> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
            BlocProvider.of<SearchBloc>(context).add(SearchEmptyEvent());
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    query.isEmpty
        ? BlocProvider.of<SearchBloc>(context).add(SearchEmptyEvent())
        : BlocProvider.of<SearchBloc>(context).add(TextChanged(query: query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchEmpty) {
          return Center(child: Text('Please enter a term to begin'));
        }
        if (state is SearchLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchSuccess) {
          return state.items.items.isEmpty
              ? Text('No results')
              : _SearchResults(items: state.items);
        }
        return Center(child: Text('Please enter a term to begin'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    query.isEmpty
        ? BlocProvider.of<SearchBloc>(context).add(SearchEmptyEvent())
        : BlocProvider.of<SearchBloc>(context).add(TextChanged(query: query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchSuccess) {
          return state.items.items.isEmpty
              ? Text('No results')
              : _SearchResults(
                  items: state.items,
                );
        }
        return Center(child: Text('Please enter a term to begin'));
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final SearchResult items;

  const _SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            child: Image.network(items.items[index].avatarUrl),
          ),
          title: Text("${items.items[index].login}"),
          onTap: () async {
            Navigator.of(context).pop();
            BlocProvider.of<SearchBloc>(context)
                .add(DisplayUserEvent(userUrl: items.items[index].url, repoUrl: items.items[index].reposUrl));
          },
        );
      },
    );
  }
}
