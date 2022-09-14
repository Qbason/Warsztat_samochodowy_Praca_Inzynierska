import 'package:first_project/pages/shop_cart_page.dart';
import 'package:first_project/pages/shop_categories_page.dart';
import 'package:first_project/pages/shop_home_page.dart';
import 'package:first_project/pages/shop_search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ShopPage extends StatefulWidget {
  final http.Client client;
  const ShopPage({super.key, required this.client});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ShopHomePage(client: widget.client),
      ShopSearchPage(client: widget.client),
      ShopCategoriesPage(client: widget.client),
      ShopCartPage(client: widget.client)
    ];
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
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
