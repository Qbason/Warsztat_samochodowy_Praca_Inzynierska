import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

class ServicesCarsPage extends StatefulWidget {
  final Session session;
  const ServicesCarsPage({super.key, required this.session});

  @override
  State<ServicesCarsPage> createState() => _ServicesCarsPageState();
}

class _ServicesCarsPageState extends State<ServicesCarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Moje auta'),
        centerTitle: true,
      ),
      body: const Text('Auto 1'),
    );
  }
}
