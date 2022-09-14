import 'package:first_project/pages/shop_cart_page.dart';
import 'package:first_project/pages/shop_categories_page.dart';
import 'package:first_project/pages/shop_home_page.dart';
import 'package:first_project/pages/shop_search_page.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    ShopHomePage(),
    ShopSearchPage(),
    ShopCategoriesPage(),
    ShopCartPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Sklep'),
        centerTitle: true,
      ),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
              icon: Icon(Icons.category_sharp), label: 'Categories'),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart_sharp), label: 'Cart'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
