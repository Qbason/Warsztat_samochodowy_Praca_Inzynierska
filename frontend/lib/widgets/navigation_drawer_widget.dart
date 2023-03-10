import 'dart:convert';

import 'package:first_project/classess/myuserinfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetchdata/fetchfunctionsuser.dart';
import '../main.dart';
import '../pages/account_page.dart';
import '../pages/home_page_client.dart';
import '../pages/opinions_page.dart';
import '../pages/services/services_page.dart';
import '../pages/shop/shop_page.dart';
import '../pages/shop/shop_page_mechanic.dart';
import '../pages/user_page.dart';
import 'package:http/http.dart' as http;
import '../classess/session.dart';
import '../urls.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final Session session;
  const NavigationDrawerWidget({super.key, required this.session});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  late String name;
  late String surname;
  late String phonenumber;
  late String email;
  late String avatar;
  late String role;
  SharedPreferences? myuserinfo;

  fetch() async {
    myuserinfo = await SharedPreferences.getInstance();
    name = myuserinfo?.getString('name') ?? 'Imię';
    surname = myuserinfo?.getString('surname') ?? 'Nazwisko';
    phonenumber = myuserinfo?.getString('phonenumber') ?? 'Numer telefonu';
    email = myuserinfo?.getString('email') ?? 'Email';
    avatar = myuserinfo?.getString('avatar') ??
        'http://jakubk.pl:2136/static/brakzdjecia.png';
    role = myuserinfo?.getString('role') ?? 'Rola nie znana';

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
            color: Colors.deepPurple,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListView(
                  children: <Widget>[
                    (myuserinfo != null)
                        ? buildHeader(
                            urlImage: avatar,
                            name: '$name $surname',
                            onClicked: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserPage(
                                  name: '$name $surname',
                                  urlImage: avatar,
                                ),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    Container(
                      padding: padding,
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Główna',
                            icon: Icons.home,
                            onClicked: () => selectedItem(context, 0),
                          ),
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Usługi',
                            icon: Icons.design_services,
                            onClicked: () => selectedItem(context, 1),
                          ),
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Sklep',
                            icon: Icons.shopping_cart,
                            onClicked: () => selectedItem(context, 2),
                          ),
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Opinie',
                            icon: Icons.comment,
                            onClicked: () => selectedItem(context, 3),
                          ),
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Konto',
                            icon: Icons.person,
                            onClicked: () => selectedItem(context, 4),
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: Colors.white70),
                          const SizedBox(height: 8),
                          buildMenuItem(
                            text: 'Wyloguj',
                            icon: Icons.logout,
                            onClicked: () => selectedItem(context, 5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePageClient(
            session: widget.session,
          ),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ServicesPage(session: widget.session),
        ));
        break;
      case 2:
        if (role == 'M') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShopPageMechanic(session: widget.session),
          ));
          break;
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShopPage(session: widget.session),
          ));
          break;
        }

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OpinionsPage(session: widget.session),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AccountPage(session: widget.session),
        ));
        break;
      case 5:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const RootPage(),
            ),
            (route) => false);
        break;
    }
  }

  buildHeader({
    required String urlImage,
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      );
}
