import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/categories.dart';
import '../../fetchdata/fetchfunctionsshop.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopCategoriesPage extends StatefulWidget {
  final Session session;
  const ShopCategoriesPage({super.key, required this.session});

  @override
  State<ShopCategoriesPage> createState() => _ShopCategoriesPageState();
}

class _ShopCategoriesPageState extends State<ShopCategoriesPage> {
  List<Categories> categorieslist = [];
  fetchCategories1(session) async {
    categorieslist = await fetchCategories(session);
    setState(() {});
  }

  @override
  void initState() {
    fetchCategories1(widget.session);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Kategorie'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: categorieslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categorieslist[index].name),
                leading: Text('PK: ${categorieslist[index].pk}'),
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
