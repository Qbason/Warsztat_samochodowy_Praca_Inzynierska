import 'dart:convert';

import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:first_project/pages/shop/shop_page.dart';
import 'package:first_project/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classess/myuserinfo.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../fetchdata/fetchfunctionsshop.dart';
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
  List<News> newestnewslist = [];
  fetchNews(session) async {
    newestnewslist = await fetchNewestNews(session);
    setState(() {});
  }

  List<Offers> newestofferslist = [];
  fetchOffers(session) async {
    newestofferslist = await fetchNewestOffers(session);
    setState(() {});
  }

  late String userrole;
  fetchuserinfo() async {
    final myuserinfo = await SharedPreferences.getInstance();
    userrole = myuserinfo.getString('role') ?? 'C';
  }

  @override
  void initState() {
    super.initState();
    fetchNews(widget.session);
    fetchOffers(widget.session);
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
                      itemCount: newestnewslist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(newestnewslist[index].title),
                          leading: Image.network(newestnewslist[index].image),
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
                          leading: Image.network(newestofferslist[index]
                                  .image ??
                              'http://jakubk.pl:2136/static/choinka_kHOqrRj.jpg'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ShopOfferPage(
                                session: widget.session,
                                offer: newestofferslist[index],
                              ),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Center(
            //     child: ElevatedButton(
            //   child: Text('click'),
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (BuildContext context) => AlertDialog(
            //               title: Text('aaa'),
            //               content: Text('aaaa'),
            //               actions: <Widget>[
            //                 MaterialButton(
            //                   elevation: 3.0,
            //                   child: const Text('Ok'),
            //                   onPressed: () {
            //                     print('dziala');
            //                     Navigator.of(context).pop();
            //                   },
            //                 ),
            //               ],
            //             ));
            //   },
            // ))
          ],
        )

        // NEW ITEMS IN SHOP
        );
  }
}
