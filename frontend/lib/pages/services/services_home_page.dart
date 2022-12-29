import 'package:first_project/classess/myrepairingcarsids.dart';
import 'package:first_project/fetchdata/fetchfunctionsservices.dart';
import 'package:first_project/pages/services/services_repairing_car_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/myrepairingcars.dart';
import '../../classess/visits.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ServicesHomePage extends StatefulWidget {
  final Session session;
  const ServicesHomePage({super.key, required this.session});

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  List<Myrepairingcars> myrepairingcars = [];
  fetchMyReparingCars1(session) async {
    myrepairingcars = await fetchMyReparingCars(session);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMyReparingCars1(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Aktualne wizyty'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 620,
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetchMyReparingCars1(widget.session);
                });
              },
              child: ListView.separated(
                itemCount: myrepairingcars.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.deepPurple.withOpacity(0.2),
                    child: ListTile(
                      title: Center(
                        child: Text(
                            '${myrepairingcars[index].visit.carbrand} ${myrepairingcars[index].visit.carmodel}: ${myrepairingcars[index].visit.datevisit}'),
                      ),
                      leading: Image.network(
                          myrepairingcars[index].visit.carphoto ??
                              'http://jakubk.pl:2136/static/brakzdjecia.png'),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ServicesRepairingCarPage(
                            session: widget.session,
                            myrepairingcar: myrepairingcars[index],
                          ),
                        ));
                        setState(() {
                          fetchMyReparingCars1(widget.session);
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
