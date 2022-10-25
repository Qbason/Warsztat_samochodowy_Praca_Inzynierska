import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ServicesHistoryPage extends StatefulWidget {
  final http.Client client;
  const ServicesHistoryPage({super.key, required this.client});

  @override
  State<ServicesHistoryPage> createState() => _ServicesHistoryPageState();
}

class _ServicesHistoryPageState extends State<ServicesHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Historia napraw'),
        centerTitle: true,
      ),
      body: const Text('Historia napraw'),
    );
  }
}
