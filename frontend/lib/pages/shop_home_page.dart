import 'dart:convert';

import 'package:first_project/classess/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classess/offers.dart';
import '../urls.dart';
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

const int itemCount = 10;

class ShopHomePage extends StatefulWidget {
  final Session session;
  const ShopHomePage({super.key, required this.session});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  List<Offers> offerslist = [];
  fetchOffers() async {
    final response = await widget.session.get(geturlOffers());

    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final responseOffers = jsonDecode(response.body);
      print(responseOffers);
      responseOffers['results'].forEach((element) {
        offerslist.add(Offers.fromMap(element));
      });
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Offers');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Sklep'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: offerslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(offerslist[index].title),
                leading: Image.network(offerslist[index].image),
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
