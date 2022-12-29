import 'package:first_project/classess/categories.dart';
import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../fetchdata/postdatafunctionsshop.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.category.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 700,
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetchOffersByCategory1(widget.session, widget.category.pk);
                });
              },
              child: ListView.separated(
                  itemCount: offersbycategorylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      color: Colors.deepPurple.withOpacity(0.2),
                      child: ListTile(
                        title: Text(offersbycategorylist[index].title),
                        leading: Image.network(
                            offersbycategorylist[index].image ??
                                'http://jakubk.pl:2136/static/brakzdjecia.png'),
                        onTap: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShopOfferPage(
                              session: widget.session,
                              offer: offersbycategorylist[index],
                            ),
                          ));
                          setState(() {
                            fetchOffersByCategory1(
                                widget.session, widget.category.pk);
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 1,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
