import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class ServicesCalendarPage extends StatefulWidget {
  final http.Client client;
  const ServicesCalendarPage({super.key, required this.client});

  @override
  State<ServicesCalendarPage> createState() => _ServicesCalendarPageState();
}

class _ServicesCalendarPageState extends State<ServicesCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Planowane wizyty'),
        centerTitle: true,
      ),
      body: const Text('Kalendarz``'),
    );
  }
}
