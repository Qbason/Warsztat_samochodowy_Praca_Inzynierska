import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../fetchdata/postdatafunctionsshop.dart';
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
              Center(
                child: MaterialButton(
                  elevation: 3.0,
                  color: Colors.deepPurple,
                  child:
                      const Text('Ok', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
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
        backgroundColor: Colors.deepPurple,
        title: const Text('Wybrany produkt'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                          widget.offer.image ??
                              'http://jakubk.pl:2136/static/brakzdjecia.png',
                          width: 100,
                          height: 100),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(widget.offer.title),
                        Text(itembase?.condition ?? 'Błąd'),
                        Text(widget.offer.price),
                        Text('${widget.offer.quantity}')
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Text(widget.offer.description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: TextField(
                        controller: controllernumber,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 1)),
                          hintText: 'Ile sztuk rezerwować?',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      child: TextButton(
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
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Rezerwuj')),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Zamknij ofertę'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
