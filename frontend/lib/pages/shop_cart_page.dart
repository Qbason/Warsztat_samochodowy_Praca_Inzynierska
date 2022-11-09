import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

class ShopCartPage extends StatefulWidget {
  final Session session;
  const ShopCartPage({super.key, required this.session});

  @override
  State<ShopCartPage> createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Koszyk'),
        centerTitle: true,
      ),
      body: const Text('Sklep guwna'),
    );
  }
}
