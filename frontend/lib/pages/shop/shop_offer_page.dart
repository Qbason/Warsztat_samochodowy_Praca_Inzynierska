import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../fetchdata/postdatafunctions.dart';
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
  Itembases? itembase;
  TextEditingController controllernumber = TextEditingController();

  fetchItembase1(session, int id) async {
    itembase = await fetchItembaseClient(session, id);
    //print('itembaaaaaaaaaaaaaaaaaaaaase $itembase');
    setState(() {});
  }

  createAlertDialog(errordata) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('${errordata[0]}'),
            content: Text('${errordata[1]}'),
            actions: <Widget>[
              MaterialButton(
                elevation: 3.0,
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));

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
                      Text(itembase?.condition ?? 'Błąd'),
                      Text(widget.offer.price),
                      Text('${widget.offer.quantity}')
                    ],
                  )
                ],
              ),
              Text(widget.offer.description),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: controllernumber,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ile sztuk rezerwować?',
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        var number = controllernumber.text;

                        var errordata = await postmakeReservation(
                            widget.session, widget.offer.pk, number);

                        if (errordata != null) {
                          createAlertDialog(errordata);
                        } else {
                          errordata = [
                            'Gotowe!',
                            'Rezerwacja została utworzona!'
                          ];
                          createAlertDialog(errordata);
                          widget.offer.quantity =
                              widget.offer.quantity - int.parse(number);
                        }
                        setState(() {});
                      },
                      child: const Text('Rezerwuj')),
                ],
              ),
              TextButton(
                child: const Text('Zamknij ofertę'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
