import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ServicesHomePage extends StatefulWidget {
  final Session session;
  const ServicesHomePage({super.key, required this.session});

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Usługi'),
        centerTitle: true,
      ),
      body: const Text('Aktualnie wykonywane usługi:'),
    );
  }
}
