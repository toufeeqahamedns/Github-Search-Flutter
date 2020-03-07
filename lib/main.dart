import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/api/github_api.dart';
import 'package:github_search/api/github_cache.dart';
import 'package:github_search/api/github_client.dart';
import 'package:github_search/bloc/search_bloc.dart';
import 'package:github_search/profile_page.dart';
import 'package:github_search/repo_page.dart';
import 'package:github_search/search_page.dart';

void main() => runApp(GithubApp());

class GithubApp extends StatefulWidget {
  @override
  _GithubAppState createState() => _GithubAppState();
}

class _GithubAppState extends State<GithubApp> {
  GithubApi githubApi;

  @override
  void initState() {
    super.initState();

    githubApi = GithubApi(
      GithubCache(),
      GithubClient(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (BuildContext context) => SearchBloc(githubApi: githubApi),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github Search',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: HomePage(title: 'Github Search'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription subscription;

  int _currentIndex = 0;
  final List<Widget> _children = [
    ProfilePage(),
    RepoPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
          
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: SearchPage()),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Repos'),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }
}
