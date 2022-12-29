import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

class OpinionsPage extends StatefulWidget {
  final Session session;
  const OpinionsPage({super.key, required this.session});

  @override
  State<OpinionsPage> createState() => _OpinionsPageState();
}

class _OpinionsPageState extends State<OpinionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Opinie'),
        centerTitle: true,
      ),
      body: const Text('Opinie klientow.'),
    );
  }
}
