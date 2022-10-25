import 'package:first_project/pages/services_calendar_page.dart';
import 'package:first_project/pages/services_cars_page.dart';
import 'package:first_project/pages/services_history_page.dart';
import 'package:first_project/pages/services_home_page.dart';
import 'package:first_project/pages/shop_cart_page.dart';
import 'package:first_project/pages/shop_categories_page.dart';
import 'package:first_project/pages/shop_home_page.dart';
import 'package:first_project/pages/shop_search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ServicesPage extends StatefulWidget {
  final http.Client client;
  const ServicesPage({super.key, required this.client});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ServicesHomePage(client: widget.client),
      ServicesCarsPage(client: widget.client),
      ServicesHistoryPage(client: widget.client),
      ServicesCalendarPage(client: widget.client)
    ];
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.car_repair_sharp), label: 'Cars'),
          NavigationDestination(
              icon: Icon(Icons.punch_clock_sharp), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month_sharp), label: 'Calendar'),
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
