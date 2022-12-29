import 'package:first_project/pages/services/services_calendar_page.dart';
import 'package:first_project/pages/services/services_cars_page.dart';
import 'package:first_project/pages/services/services_history_page.dart';
import 'package:first_project/pages/services/services_home_page.dart';
import 'package:first_project/pages/shop/shop_cart_page.dart';
import 'package:first_project/pages/shop/shop_categories_page.dart';
import 'package:first_project/pages/shop/shop_home_page.dart';
import 'package:first_project/pages/shop/shop_search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ServicesPage extends StatefulWidget {
  final Session session;
  const ServicesPage({super.key, required this.session});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ServicesHomePage(session: widget.session),
      ServicesCarsPage(session: widget.session),
      ServicesHistoryPage(session: widget.session),
      ServicesCalendarPage(session: widget.session)
    ];
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.white.withOpacity(0.25),
            labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Colors.deepPurple,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home, color: Colors.white), label: 'Główna'),
            NavigationDestination(
                icon: Icon(Icons.car_repair_sharp, color: Colors.white),
                label: 'Auta'),
            NavigationDestination(
                icon: Icon(Icons.punch_clock_sharp, color: Colors.white),
                label: 'Historia'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_sharp, color: Colors.white),
                label: 'Kalendarz'),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
      ),
    );
  }
}
