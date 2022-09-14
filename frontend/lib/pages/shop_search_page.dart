import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ShopSearchPage extends StatefulWidget {
  final http.Client client;
  const ShopSearchPage({super.key, required this.client});

  @override
  State<ShopSearchPage> createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends State<ShopSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Wyszukiwanie'),
        centerTitle: true,
      ),
      body: const Text('Sklep wyszukiwanie'),
    );
  }
}
