import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class ShopCategoriesPage extends StatefulWidget {
  const ShopCategoriesPage({super.key});

  @override
  State<ShopCategoriesPage> createState() => _ShopCategoriesPageState();
}

class _ShopCategoriesPageState extends State<ShopCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Kategorie'),
        centerTitle: true,
      ),
      body: const Text('Sklep kategorie'),
    );
  }
}
