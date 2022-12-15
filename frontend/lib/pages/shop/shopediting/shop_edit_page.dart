import 'package:first_project/pages/shop/shopediting/shop_add_itembase_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/navigation_drawer_widget.dart';
import '../../../classess/session.dart';

class ShopEditPage extends StatefulWidget {
  final Session session;
  const ShopEditPage({super.key, required this.session});

  @override
  State<ShopEditPage> createState() => _ShopEditPageState();
}

class _ShopEditPageState extends State<ShopEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(session: widget.session),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Edycja Sklepu'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopAddItembasePage(
                        session: widget.session,
                      ),
                    ));
                  },
                  child: const Text('Add itembase'))
            ],
          )),
        ));
  }
}
