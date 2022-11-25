import 'package:first_project/classess/myreservations.dart';
import 'package:first_project/fetchdata/fetchfunctionsshop.dart';
import 'package:first_project/pages/shop/shop_cart_myreservation_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopCartPage extends StatefulWidget {
  final Session session;
  const ShopCartPage({super.key, required this.session});

  @override
  State<ShopCartPage> createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  List<Myreservations> myreservationslist = [];
  fetchMyReservations1(session) async {
    myreservationslist = await fetchMyReservations(session);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMyReservations1(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Koszyk'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text('Moje rezerwacje:',
                style: (TextStyle(
                  fontSize: 30,
                ))),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: myreservationslist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(myreservationslist[index].title),
                      leading: Image.network(myreservationslist[index].image),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShopCartMyReservationPage(
                            session: widget.session,
                            myreservation: myreservationslist[index],
                          ),
                        ));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
