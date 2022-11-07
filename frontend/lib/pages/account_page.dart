import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';
import '../session.dart';

class AccountPage extends StatefulWidget {
  final Session session;
  const AccountPage({super.key, required this.session});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Konto'),
        centerTitle: true,
      ),
      body: const Text('Zmiana danych konta. Dodanie zdjecia.'),
    );
  }
}
