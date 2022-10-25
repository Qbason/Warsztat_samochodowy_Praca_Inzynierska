import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ServicesCarsPage extends StatefulWidget {
  final http.Client client;
  const ServicesCarsPage({super.key, required this.client});

  @override
  State<ServicesCarsPage> createState() => _ServicesCarsPageState();
}

class _ServicesCarsPageState extends State<ServicesCarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Moje auta'),
        centerTitle: true,
      ),
      body: const Text('Auto 1'),
    );
  }
}
