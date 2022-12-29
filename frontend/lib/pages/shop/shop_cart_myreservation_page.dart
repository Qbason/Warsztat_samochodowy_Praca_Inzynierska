import 'package:first_project/classess/myreservations.dart';
import 'package:first_project/fetchdata/fetchfunctionsshop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../fetchdata/postdatafunctionsshop.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopCartMyReservationPage extends StatefulWidget {
  final Session session;
  final Myreservations myreservation;
  const ShopCartMyReservationPage(
      {super.key, required this.session, required this.myreservation});

  @override
  State<ShopCartMyReservationPage> createState() =>
      _ShopCartMyReservationPageState();
}

class _ShopCartMyReservationPageState extends State<ShopCartMyReservationPage> {
  Itembases? itembase;

  fetchItembase1(session, int id) async {
    itembase = await fetchItembaseClient(session, id);
    if (itembase?.condition == 'N') {
      itembase?.condition = 'Nowy';
    } else if (itembase?.condition == 'U') {
      itembase?.condition = 'Używany';
    } else if (itembase?.condition == 'D') {
      itembase?.condition = 'Uszkodzony';
    }
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
    fetchItembase1(widget.session, widget.myreservation.itembase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Zarezerwowany produkt'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      flex: 1,
                      child: Image.network(
                          widget.myreservation.image ??
                              'http://jakubk.pl:2136/static/brakzdjecia.png',
                          width: 100,
                          height: 100),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(widget.myreservation.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Stan produktu: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(itembase?.condition ?? 'Nieznany'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Cena produktu: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${widget.myreservation.price} zł'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Ilość zarezerwowanych sztuk: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${widget.myreservation.reservednumber}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Data rezerwacji: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(widget.myreservation.datecreated),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  const Text('Opis produktu:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.myreservation.description),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () async {
                            var errordata = await postcancelReservation(
                                widget.session,
                                widget.myreservation.pk,
                                widget.myreservation.reservednumber);

                            if (errordata != null) {
                              createAlertDialog(errordata);
                            } else {
                              errordata = [
                                'Gotowe!',
                                'Rezerwacja została anulowana!'
                              ];
                              createAlertDialog(errordata);
                              widget.myreservation.reservednumber = 0;
                            }
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Anuluj rezerwację!')),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Zamknij'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
