import 'package:first_project/classess/myrepairingcars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/itembases.dart';
import '../../classess/offers.dart';
import '../../fetchdata/postdatafunctionsshop.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';
import '../../fetchdata/fetchfunctionsshop.dart';

class ServicesRepairingCarPage extends StatefulWidget {
  final Session session;
  final Myrepairingcars myrepairingcar;
  const ServicesRepairingCarPage(
      {super.key, required this.session, required this.myrepairingcar});

  @override
  State<ServicesRepairingCarPage> createState() =>
      _ServicesRepairingCarPageState();
}

class _ServicesRepairingCarPageState extends State<ServicesRepairingCarPage> {
  Itembases? itembase;
  TextEditingController controllernumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Naprawiane auto'),
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
                      widget.myrepairingcar.visit.carphoto ??
                          'http://jakubk.pl:2136/static/brakzdjecia.png',
                      width: 200,
                      height: 100),
                ),
                Text(
                  '${widget.myrepairingcar.visit.carbrand} ${widget.myrepairingcar.visit.carmodel}',
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
                    Text(widget.myrepairingcar.visit.carNrVIN)
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Data wizyty: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.myrepairingcar.visit.datevisit),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Planowane zakończenie: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.myrepairingcar.visit.datevisitend ??
                        'brak infromacji')
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const Text(
                      'Tytuł wizyty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.myrepairingcar.visit.visitdescritpiontitle),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const Text(
                      'Przyczyna wizyty',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.myrepairingcar.visit.visitreason),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const Text(
                      'Opis usterki',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.myrepairingcar.visit.visitdescritpioncontent),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Usługi związane z wizytą:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    itemCount: widget.myrepairingcar.services.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Center(
                          child: Column(
                            children: [
                              Text(
                                  widget.myrepairingcar.services[index]
                                      .servicename,
                                  style: const TextStyle(fontSize: 20)),
                              if (widget.myrepairingcar.services[index]
                                      .progress ==
                                  'T')
                                const Text('Jeszcze nie wykonano',
                                    style: TextStyle(color: Colors.red))
                              else if (widget.myrepairingcar.services[index]
                                      .progress ==
                                  'D')
                                const Text('W trakcie wykonywania',
                                    style: TextStyle(color: Colors.orange))
                              else if (widget.myrepairingcar.services[index]
                                      .progress ==
                                  'DN')
                                const Text('Wykonano',
                                    style: TextStyle(color: Colors.green))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 1,
                    ),
                  ),
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
