import 'dart:convert';

import 'package:first_project/pages/shop_page.dart';
import 'package:first_project/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classess/myuserinfo.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

class HomePageClient extends StatefulWidget {
  final Session session;
  const HomePageClient({super.key, required this.session});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  List<News> newslist = [];
  fetchNews() async {
    final queryParameters = {
      'count': '3', // how many news it should show
    };
    final response = await widget.session.get(geturlNews(queryParameters));

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final responseNews = jsonDecode(response.body);
      print(responseNews);
      responseNews['results'].forEach((element) {
        newslist.add(News.fromMap(element));
      });
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load News');
    }
  }

  List<Offers> newestofferslist = [];
  fetchNewestOffers() async {
    final queryParameters = {
      'count': '3', // how many news it should show
    };
    final response =
        await widget.session.get(geturlNewestOffers(queryParameters));

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final responsenewestOffers = jsonDecode(response.body);
      print(responsenewestOffers);
      responsenewestOffers['results'].forEach((element) {
        newestofferslist.add(Offers.fromMap(element));
      });
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Newest Offers');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
    fetchNewestOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: NavigationDrawerWidget(session: widget.session),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Mechanika Samochodowa'),
          centerTitle: true,
        ),
        body:
            // NEWSY
            Column(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: newslist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(newslist[index].title),
                          leading: Image.network(newslist[index].image),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            // ACTUAL SERVICES
            Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: newestofferslist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(newestofferslist[index].title),
                          leading: Image.network(newestofferslist[index].image),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShopPage(session: widget.session),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        )

        // NEW ITEMS IN SHOP
        );
  }
}
