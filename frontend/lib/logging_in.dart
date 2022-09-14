import 'package:first_project/pages/home_page_client.dart';
import 'package:flutter/material.dart';

import 'pages/login_page.dart';

class LogginginPage extends StatefulWidget {
  const LogginginPage({super.key});

  @override
  State<LogginginPage> createState() => _LogginginPageState();
}

class _LogginginPageState extends State<LogginginPage> {
  TextEditingController controllerlogin = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Flutter'),
        automaticallyImplyLeading:
            false, // wyłączenie automatycznego tworzenia strzałeczki do wracania do poprzedniej strony
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            //pop - wraca do poprzedniej strony, z której wcześnie przyszło się dzięki navigator push, zamyka akutalną stronę.
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: controllerlogin,
            maxLines: 1,
          ),
          TextField(
            controller: controllerpassword,
            maxLines: 1,
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerlogin.text == 'karol' &&
                  controllerpassword.text == '123') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePageClient();
                    },
                  ),
                );
              } else {}
            },
            child: const Text("Log in"),
          )
        ],
      ),
    );
  }
}
