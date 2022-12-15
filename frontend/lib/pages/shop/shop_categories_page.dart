import 'package:first_project/pages/shop/shop_offer_by_category_page.dart';
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
    categorieslist = await fetchCategoriesClient(session);
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
        backgroundColor: Colors.deepPurple,
        title: const Text('Kategorie'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: ListView.separated(
            itemCount: categorieslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  categorieslist[index].name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShopOfferByCategoryPage(
                      session: widget.session,
                      category: categorieslist[index],
                    ),
                  ));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
