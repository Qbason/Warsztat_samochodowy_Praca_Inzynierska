import 'package:first_project/pages/shop/shop_offer_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../classess/offers.dart';
import '../../fetchdata/fetchfunctionsshop.dart';
import '../../widgets/navigation_drawer_widget.dart';
import '../../classess/session.dart';

class ShopSearchPage extends StatefulWidget {
  final Session session;
  const ShopSearchPage({super.key, required this.session});

  @override
  State<ShopSearchPage> createState() => _ShopSearchPageState();
}

class _ShopSearchPageState extends State<ShopSearchPage> {
  TextEditingController controllersearch = TextEditingController();
  List<Offers> offersbytitlelist = [];
  fetchOffersByTitle1(session, title) async {
    offersbytitlelist = await fetchOffersByTitle(session, title);
    setState(() {});
  }

  createAlertDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('Błąd!'),
            content: const Text(
                'Pole wyszukiwanej frazy w tytule nie może być puste!!!'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: TextField(
                  controller: controllersearch,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Szukaj...',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: TextButton.icon(
                    onPressed: () async {
                      if (controllersearch.text == '') {
                        createAlertDialog();
                      }
                      await fetchOffersByTitle1(
                          widget.session, controllersearch.text);
                      controllersearch.text = '';
                      //hiding keyboard
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    },
                    icon: const Icon(Icons.search),
                    label: const Text(''),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ))),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Szukane produkty:',
                    style: (TextStyle(
                      fontSize: 30,
                    ))),
              ),
              const SizedBox(height: 20),
              if (offersbytitlelist.isNotEmpty)
                SizedBox(
                  height: 500,
                  child: ListView.separated(
                    itemCount: offersbytitlelist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(offersbytitlelist[index].title),
                        leading: Image.network(offersbytitlelist[index].image ??
                            'http://jakubk.pl:2136/static/brakzdjecia.png'),
                        onTap: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShopOfferPage(
                              session: widget.session,
                              offer: offersbytitlelist[index],
                            ),
                          ));
                          setState(() {
                            fetchOffersByTitle1(
                                widget.session, controllersearch.text);
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
