import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopSearchPage extends StatefulWidget {
  final Session session;
  const ShopSearchPage({super.key, required this.session});

  @override
  State<ShopSearchPage> createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends State<ShopSearchPage> {
  TextEditingController controllersearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          children: [
            SizedBox(
              width: 180,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: controllersearch,
                  maxLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  //napisac co bedzie robic if controllersearch...
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: const Text('Sklep wyszukiwanie'),
    );
  }
}
