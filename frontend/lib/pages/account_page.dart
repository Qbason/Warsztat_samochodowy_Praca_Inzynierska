import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/navigation_drawer_widget.dart';

class AccountPage extends StatefulWidget {
  final http.Client client;
  const AccountPage({super.key, required this.client});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(client: widget.client),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Konto'),
        centerTitle: true,
      ),
      body: const Text('Zmiana danych konta. Dodanie zdjecia.'),
    );
  }
}
