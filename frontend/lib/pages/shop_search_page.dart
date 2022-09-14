import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class ShopSearchPage extends StatefulWidget {
  const ShopSearchPage({super.key});

  @override
  State<ShopSearchPage> createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends State<ShopSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Wyszukiwanie'),
        centerTitle: true,
      ),
      body: const Text('Sklep wyszukiwanie'),
    );
  }
}
