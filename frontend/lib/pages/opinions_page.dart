import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class OpinionsPage extends StatefulWidget {
  final http.Client client;
  const OpinionsPage({super.key, required this.client});

  @override
  State<OpinionsPage> createState() => _OpinionsPageState();
}

class _OpinionsPageState extends State<OpinionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Opinie'),
        centerTitle: true,
      ),
      body: const Text('Opinie klientow.'),
    );
  }
}
