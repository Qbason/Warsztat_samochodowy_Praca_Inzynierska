import 'package:first_project/pages/services/services_cardetails_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/mycars.dart';
import '../../fetchdata/fetchfunctionsservices.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ServicesCarsPage extends StatefulWidget {
  final Session session;
  const ServicesCarsPage({super.key, required this.session});

  @override
  State<ServicesCarsPage> createState() => _ServicesCarsPageState();
}

class _ServicesCarsPageState extends State<ServicesCarsPage> {
  List<Mycars> mycarslist = [];
  fetchMyCars1(session) async {
    mycarslist = await fetchMyCars(session);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMyCars1(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Moje auta'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: mycarslist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(mycarslist[index].nrVIN),
                  leading: Image.network(mycarslist[index].photo ??
                      'http://jakubk.pl:2136/static/brakzdjecia.png'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServicesCarDetailsPage(
                        session: widget.session,
                        mycar: mycarslist[index],
                      ),
                    ));
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
