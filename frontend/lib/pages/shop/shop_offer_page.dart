import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';
import '../../fetchdata/fetchfunctionsshop.dart';

class ShopOfferPage extends StatefulWidget {
  final Session session;
  final Offers offer;
  const ShopOfferPage({super.key, required this.session, required this.offer});

  @override
  State<ShopOfferPage> createState() => _ShopOfferPageState();
}

class _ShopOfferPageState extends State<ShopOfferPage> {
  Itembases itembase = Itembases(
    pk: -1,
    name: 'wczytywanie',
    condition: 'wczytywanie',
    category: -1,
    price: 'wczytywanie',
  );

  fetchItembase1(session, int id) async {
    itembase = await fetchItembase(session, id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchItembase1(widget.session, widget.offer.itembase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Wybrany produkt'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(widget.offer.image, width: 50, height: 50),
                  Column(
                    children: [
                      Text(widget.offer.title),
                      Text(itembase.condition),
                      Text(widget.offer.price),
                      Text('${widget.offer.quantity}')
                    ],
                  )
                ],
              ),
              Text(widget.offer.description),
              Row(
                children: [
                  const Text('Ilość do rezerwacji - pole zrob'),
                  const Text('Rezerwuj - przycisk'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
