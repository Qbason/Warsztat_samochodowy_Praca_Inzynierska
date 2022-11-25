import 'package:first_project/classess/myreservations.dart';
import 'package:first_project/fetchdata/fetchfunctionsshop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../fetchdata/postdatafunctions.dart';
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
    fetchItembase1(widget.session, widget.myreservation.itembase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Zarezerwowany produkt'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(widget.myreservation.image,
                      width: 50, height: 50),
                  Column(
                    children: [
                      Text(widget.myreservation.title),
                      Text(itembase?.condition ?? 'Błąd'),
                      Text(widget.myreservation.price),
                      Text('${widget.myreservation.reservednumber}'),
                      Text(widget.myreservation.datecreated)
                    ],
                  )
                ],
              ),
              Text(widget.myreservation.description),
              TextButton(
                  onPressed: () async {
                    var errordata = await postcancelReservation(
                        widget.session,
                        widget.myreservation.pk,
                        widget.myreservation.reservednumber);

                    if (errordata != null) {
                      createAlertDialog(errordata);
                    } else {
                      errordata = ['Gotowe!', 'Rezerwacja została anulowana!'];
                      createAlertDialog(errordata);
                      widget.myreservation.reservednumber = 0;
                    }
                    setState(() {});
                  },
                  child: const Text('Anuluj rezerwację!')),
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
