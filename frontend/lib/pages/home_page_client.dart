import 'dart:convert';

import 'package:first_project/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../news.dart';
import '../widgets/navigation_drawer_widget.dart';

class HomePageClient extends StatefulWidget {
  final http.Client client;
  const HomePageClient({super.key, required this.client});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  Future<News> fetchAlbum() async {
    final response = await widget.client.get(geturlNews());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return News.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  late Future<News> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Mechanika Samochodowa'),
        centerTitle: true,
      ),
      body: FutureBuilder<News>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.title);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
