import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ServicesHomePage extends StatefulWidget {
  final http.Client client;
  const ServicesHomePage({super.key, required this.client});

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Usługi'),
        centerTitle: true,
      ),
      body: const Text('Aktualnie wykonywane usługi:'),
    );
  }
}
