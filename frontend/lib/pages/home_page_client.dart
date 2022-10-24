import 'dart:convert';

import 'package:first_project/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../news.dart';
import '../widgets/navigation_drawer_widget.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

class HomePageClient extends StatefulWidget {
  final http.Client client;
  const HomePageClient({super.key, required this.client});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  List<News> newslist = [];
  fetchNews() async {
    final queryParameters = {
      'count': '3',
    };
    final response = await widget.client.get(geturlNews(queryParameters));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List responseNews = jsonDecode(response.body);
      print(responseNews);
      responseNews.forEach((element) {
        newslist.add(News.fromMap(element));
      });
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load News');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Mechanika Samochodowa'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: newslist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newslist[index].title),
            leading:
                Image.network('http://jakubk.pl:2136' + newslist[index].image),
          );
        },
      ),
    );
  }
}
