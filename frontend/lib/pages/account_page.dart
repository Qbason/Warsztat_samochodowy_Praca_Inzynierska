import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/navigation_drawer_widget.dart';
import '../classess/session.dart';

class AccountPage extends StatefulWidget {
  final Session session;
  const AccountPage({super.key, required this.session});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
    if (role == 'C') {
      role = 'klient';
    } else if (role == 'M') {
      role = 'mechanik';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(session: widget.session),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Konto'),
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
                  child: Image.network(avatar, width: 200, height: 200),
                ),
                Text(
                  '$name $surname',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Numer telefonu: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(phonenumber, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Adres E-mail: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(email, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
