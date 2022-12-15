import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../classess/session.dart';
import '../../../widgets/navigation_drawer_widget.dart';

class ShopAddItembasePage extends StatefulWidget {
  final Session session;
  const ShopAddItembasePage({super.key, required this.session});

  @override
  State<ShopAddItembasePage> createState() => _ShopAddItembasePageState();
}

class _ShopAddItembasePageState extends State<ShopAddItembasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Zarezerwowany produkt'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Text('a'),
        ),
      ),
    );
  }
}
