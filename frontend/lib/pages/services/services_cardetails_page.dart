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
        title: Text('Nr VIN: ${widget.mycar.nrVIN}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(widget.mycar.nrVIN),
            Text(widget.mycar.carbrand),
            Text(widget.mycar.carmodel),
            Text(widget.mycar.cartype),
            Image.network(widget.mycar.photo ??
                'http://jakubk.pl:2136/static/brakzdjecia.png'),
          ],
        )),
      ),
    );
  }
}
