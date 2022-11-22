import 'package:first_project/pages/shop/shop_cart_page.dart';
import 'package:first_project/pages/shop/shop_categories_page.dart';
import 'package:first_project/pages/shop/shop_home_page.dart';
import 'package:first_project/pages/shop/shop_search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopPage extends StatefulWidget {
  final Session session;
  const ShopPage({super.key, required this.session});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ShopHomePage(session: widget.session),
      ShopSearchPage(session: widget.session),
      ShopCategoriesPage(session: widget.session),
      ShopCartPage(session: widget.session)
    ];
    return Scaffold(
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
