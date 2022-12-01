import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/offers.dart';
import '../../fetchdata/fetchfunctionsshop.dart';
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
  List<Offers> offersbytitlelist = [];
  fetchOffersByTitle1(session, title) async {
    offersbytitlelist = await fetchOffersByTitle(session, title);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

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
                onTap: () async {
                  await fetchOffersByTitle1(
                      widget.session, controllersearch.text);
                  setState(() {});
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
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text('Szukane produkty:',
                  style: (TextStyle(
                    fontSize: 30,
                  ))),
            ),
            const SizedBox(height: 20),
            if (offersbytitlelist.isNotEmpty)
              SingleChildScrollView(
                child: SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: offersbytitlelist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(offersbytitlelist[index].title),
                        leading: Image.network(offersbytitlelist[index].image ??
                            'http://jakubk.pl:2136/static/choinka_kHOqrRj.jpg'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShopOfferPage(
                              session: widget.session,
                              offer: offersbytitlelist[index],
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
