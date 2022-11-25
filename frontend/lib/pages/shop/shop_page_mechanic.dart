import 'package:first_project/pages/shop/shop_cart_page.dart';
import 'package:first_project/pages/shop/shop_categories_page.dart';
import 'package:first_project/pages/shop/shop_edit_page.dart';
import 'package:first_project/pages/shop/shop_home_page.dart';
import 'package:first_project/pages/shop/shop_search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopPageMechanic extends StatefulWidget {
  final Session session;
  const ShopPageMechanic({super.key, required this.session});

  @override
  State<ShopPageMechanic> createState() => _ShopPageMechanicState();
}

class _ShopPageMechanicState extends State<ShopPageMechanic> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ShopHomePage(session: widget.session),
      ShopSearchPage(session: widget.session),
      ShopCategoriesPage(session: widget.session),
      ShopEditPage(session: widget.session)
    ];
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
              icon: Icon(Icons.category_sharp), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.edit), label: 'Edit'),
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
