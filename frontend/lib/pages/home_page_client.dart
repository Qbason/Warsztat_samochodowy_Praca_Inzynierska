import 'package:flutter/material.dart';

import '../widgets/navigation_drawer_widget.dart';

class HomePageClient extends StatelessWidget {
  const HomePageClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Mechanika Samochodowa'),
        centerTitle: true,
      ),
      body: const Text('Strona guwna'),
    );
  }
}
