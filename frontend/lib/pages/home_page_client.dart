import 'dart:convert';

import 'package:first_project/pages/services/services_repairing_car_page.dart';
import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:first_project/pages/shop/shop_page.dart';
import 'package:first_project/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classess/myrepairingcars.dart';
import '../classess/myuserinfo.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../fetchdata/fetchfunctionsservices.dart';
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

  List<Myrepairingcars> myrepairingcars = [];
  fetchMyReparingCars1(session) async {
    myrepairingcars = await fetchMyReparingCars(session);
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
    fetchMyReparingCars1(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: NavigationDrawerWidget(session: widget.session),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Mechanika Samochodowa'),
          centerTitle: true,
        ),
        body:
            // NEWSY
            SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Ogłoszenia!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.separated(
                                itemCount: newestnewslist.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    color: Colors.deepPurple.withOpacity(0.2),
                                    child: ListTile(
                                      title: Text(newestnewslist[index].title),
                                      leading: Image.network(newestnewslist[
                                                  index]
                                              .image ??
                                          'http://jakubk.pl:2136/static/brakzdjecia.png'),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
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
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Aktualne wizyty!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {
                                    fetchMyReparingCars1(widget.session);
                                  });
                                },
                                child: ListView.separated(
                                  itemCount: myrepairingcars.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      color: Colors.deepPurple.withOpacity(0.2),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                              '${myrepairingcars[index].visit.carbrand} ${myrepairingcars[index].visit.carmodel}: ${myrepairingcars[index].visit.datevisit}'),
                                        ),
                                        leading: Image.network(myrepairingcars[
                                                    index]
                                                .visit
                                                .carphoto ??
                                            'http://jakubk.pl:2136/static/brakzdjecia.png'),
                                        onTap: () async {
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesRepairingCarPage(
                                              session: widget.session,
                                              myrepairingcar:
                                                  myrepairingcars[index],
                                            ),
                                          ));
                                          setState(() {
                                            fetchNews(widget.session);
                                            fetchOffers(widget.session);
                                            fetchMyReparingCars1(
                                                widget.session);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // NEWEST OFFERS
                Column(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Najnowsze oferty w sklepie!',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  setState(() {
                                    fetchOffers(widget.session);
                                  });
                                },
                                child: ListView.separated(
                                  itemCount: newestofferslist.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      color: Colors.deepPurple.withOpacity(0.2),
                                      child: ListTile(
                                        title:
                                            Text(newestofferslist[index].title),
                                        leading: Image.network(newestofferslist[
                                                    index]
                                                .image ??
                                            'http://jakubk.pl:2136/static/brakzdjecia.png'),
                                        onTap: () async {
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => ShopOfferPage(
                                              session: widget.session,
                                              offer: newestofferslist[index],
                                            ),
                                          ));
                                          setState(() {
                                            fetchOffers(widget.session);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
            ),
          ),
        )

        // NEW ITEMS IN SHOP
        );
  }
}
