import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/session.dart';
import '../../classess/mycars.dart';
import '../../fetchdata/fetchfunctionsservices.dart';

class ServicesCarDetailsPage extends StatefulWidget {
  final Session session;
  final Mycars mycar;
  const ServicesCarDetailsPage(
      {super.key, required this.session, required this.mycar});

  @override
  State<ServicesCarDetailsPage> createState() => _ServicesCarDetailsPageState();
}

class _ServicesCarDetailsPageState extends State<ServicesCarDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('${widget.mycar.carbrand} ${widget.mycar.carmodel}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      widget.mycar.photo ??
                          'http://jakubk.pl:2136/static/brakzdjecia.png',
                      width: 200,
                      height: 100),
                ),
                Text(
                  '${widget.mycar.carbrand} ${widget.mycar.carmodel}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Numer VIN pojazdu: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.mycar.nrVIN)
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Typ auta: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.mycar.cartype),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 50),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Zamknij'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
