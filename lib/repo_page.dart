import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/bloc/search_bloc.dart';
import 'package:github_search/bloc/search_state.dart';
import 'package:github_search/models/repos.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is UserLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserRepoLoaded) {
          return RepoScreen(repo: state.repo);
        }
        return Center(
          child: Text('Search User to view Details'),
        );
      },
    ));
  }
}

class RepoScreen extends StatelessWidget {
  final List<Repo> repo;

  RepoScreen({this.repo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repo.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("${repo[index].name}"),
          onTap: () async {
            if (await canLaunch(repo[index].url)) {
              launch(repo[index].url);
            }
          },
        );
      },
    );
  }
}
