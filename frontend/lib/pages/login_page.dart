import 'package:first_project/pages/home_page_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_project/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classess/myuserinfo.dart';
import '../classess/session.dart';
import '../fetchdata/fetchfunctionsuser.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // client
  Session session = Session();
  //var client = http.Client();
  // text controllers
  TextEditingController controllerlogin = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  Future<String?> attemptLogIn(String username, String password) async {
    var responseCreateToken = await http.post(geturlCreateToken(),
        body: {"username": username, "password": password});
    if (responseCreateToken.statusCode == 200) return responseCreateToken.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //LOGO
                const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                // email address
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: controllerlogin,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: controllerpassword,
                        maxLines: 1,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Hasło',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //log in button -
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () async {
                      var username = controllerlogin.text;
                      var password = controllerpassword.text;
                      bool result =
                          await session.attemptLogIn(username, password);
                      try {
                        if (result) {
                          final Myuserinfo myuserinfo1 =
                              await fetchMyUserInfo(session);

                          //saving my user info to storage

                          final myuserinfo =
                              await SharedPreferences.getInstance();

                          await myuserinfo.setString('name', myuserinfo1.name);
                          await myuserinfo.setString(
                              'surname', myuserinfo1.surname);
                          await myuserinfo.setString(
                              'phonenumber', myuserinfo1.phonenumber);
                          await myuserinfo.setString(
                              'email', myuserinfo1.email);
                          await myuserinfo.setString(
                              'avatar', myuserinfo1.avatar);

                          //saving session tokens info to storage

                          final sessionstorage =
                              await SharedPreferences.getInstance();

                          await sessionstorage.setString(
                              'tokenaccess', session.tokenaccess);
                          await sessionstorage.setString(
                              'tokenrefresh', session.tokenrefresh);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePageClient(session: session),
                              ),
                              (route) => false);
                        } else {
                          print("TOKEN NIE UTWORZONY");
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Zaloguj',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //forgot password? --------------------------------------- zrobić przechodzenie na strone z zapominaniem hasla
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nie pamiętasz hasła? Naciśnij ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'tutaj',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
