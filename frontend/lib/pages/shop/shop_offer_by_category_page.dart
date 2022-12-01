import 'package:first_project/classess/categories.dart';
import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../fetchdata/postdatafunctions.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';
import '../../fetchdata/fetchfunctionsshop.dart';

class ShopOfferByCategoryPage extends StatefulWidget {
  final Session session;
  final Categories category;
  const ShopOfferByCategoryPage(
      {super.key, required this.session, required this.category});

  @override
  State<ShopOfferByCategoryPage> createState() =>
      _ShopOfferByCategoryPageState();
}

class _ShopOfferByCategoryPageState extends State<ShopOfferByCategoryPage> {
  List<Offers> offersbycategorylist = [];
  fetchOffersByCategory1(session, category) async {
    offersbycategorylist = await fetchOffersByCategory(session, category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOffersByCategory1(widget.session, widget.category.pk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Sklep'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Kategoria: ${widget.category.name}',
                style: (const TextStyle(
                  fontSize: 30,
                ))),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: offersbycategorylist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(offersbycategorylist[index].title),
                      leading: Image.network(offersbycategorylist[index]
                              .image ??
                          'http://jakubk.pl:2136/static/choinka_kHOqrRj.jpg'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShopOfferPage(
                            session: widget.session,
                            offer: offersbycategorylist[index],
                          ),
                        ));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
