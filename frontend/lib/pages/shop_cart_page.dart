import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class ShopCartPage extends StatefulWidget {
  const ShopCartPage({super.key});

  @override
  State<ShopCartPage> createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Koszyk'),
        centerTitle: true,
      ),
      body: const Text('Sklep guwna'),
    );
  }
}
