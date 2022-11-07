import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';
import '../session.dart';

class ShopCategoriesPage extends StatefulWidget {
  final Session session;
  const ShopCategoriesPage({super.key, required this.session});

  @override
  State<ShopCategoriesPage> createState() => _ShopCategoriesPageState();
}

class _ShopCategoriesPageState extends State<ShopCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Kategorie'),
        centerTitle: true,
      ),
      body: const Text('Sklep kategorie'),
    );
  }
}
