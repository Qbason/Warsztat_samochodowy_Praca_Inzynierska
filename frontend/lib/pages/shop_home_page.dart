import 'dart:convert';

import 'package:first_project/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

const int itemCount = 10;

class ShopHomePage extends StatefulWidget {
  final http.Client client;
  const ShopHomePage({super.key, required this.client});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Sklep'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg',
                  ),
                  Column(
                    children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
                  )
                ],
              ),
              Row(
                children: [
                  Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg'),
                  Column(
                    children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
                  )
                ],
              ),
              Row(
                children: [
                  Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg'),
                  Column(
                    children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
                  )
                ],
              ),
              Row(
                children: [
                  Image.network(
                      'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg'),
                  Column(
                    children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
