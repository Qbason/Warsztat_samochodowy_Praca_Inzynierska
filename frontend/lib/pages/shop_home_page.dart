import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

const int itemCount = 10;

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Column(
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg',
              ),
              Row(
                children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
              )
            ],
          ),
          Column(
            children: [
              Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/010/882/519/small/adjustable-wrench-tool-illustration-icon-industry-work-equipment-adjustable-wrench-mechanic-spanner-key-repair-icon-construction-symbol-tool-support-utility-factory-instrument-sign-vector.jpg'),
              Row(
                children: const [Text('Nazwa'), Text('Stan'), Text('Cena')],
              )
            ],
          ),
        ],
      ),
    );
  }
}
