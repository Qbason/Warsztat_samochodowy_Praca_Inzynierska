import 'dart:convert';

import 'package:first_project/classess/news.dart';
import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:first_project/pages/shop/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/offers.dart';
import '../../fetchdata/fetchfunctionsshop.dart';
import '../../urls.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

const int itemCount = 10;

class ShopHomePage extends StatefulWidget {
  final Session session;
  const ShopHomePage({super.key, required this.session});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  List<Offers> newestofferslist = [];
  fetchOffers(session) async {
    newestofferslist = await fetchNewestOffers(session);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOffers(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Najnowsze produkty'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 625,
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.deepPurple.withOpacity(0.2),
                    child: ListTile(
                      title: Text(newestofferslist[index].title),
                      leading: Image.network(newestofferslist[index].image ??
                          'http://jakubk.pl:2136/static/brakzdjecia.png'),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
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
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
