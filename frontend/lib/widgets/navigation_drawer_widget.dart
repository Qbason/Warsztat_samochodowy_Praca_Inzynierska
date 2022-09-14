import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/shop_page.dart';
import '../pages/user_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = 'Karol CRC';
    final email = 'karolcrc@gmail.com';
    final urlImage = 'https://radzymin.pl/download//797/jan-pawel-ii.jpeg';

    return Drawer(
        child: Material(
            color: const Color.fromRGBO(50, 75, 205, 1),
            child: ListView(
              children: <Widget>[
                buildHeader(
                  urlImage: urlImage,
                  name: name,
                  email: email,
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserPage(
                      name: name,
                      urlImage: urlImage,
                    ),
                  )),
                ),
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
                        text: 'Rezerwacje',
                        icon: Icons.calendar_month_sharp,
                        onClicked: () => selectedItem(context, 3),
                      ),
                      const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Historia napraw',
                        icon: Icons.access_time_filled_sharp,
                        onClicked: () => selectedItem(context, 4),
                      ),
                      const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Opinie',
                        icon: Icons.comment,
                        onClicked: () => selectedItem(context, 5),
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white70),
                      const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Wyloguj',
                        icon: Icons.logout,
                        onClicked: () => selectedItem(context, 6),
                      ),
                    ],
                  ),
                )
              ],
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
          builder: (context) => RootPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RootPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShopPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RootPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RootPage(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RootPage(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RootPage(),
        ));
        break;
    }
  }

  buildHeader({
    required String urlImage,
    required String name,
    required String email,
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
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
