import 'package:flutter/material.dart';
import '../logging_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            //wyświetli inną stronę nad tą, w tym przypadku LearnFlutterPage
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LogginginPage();
              },
            ),
          );
        },
        child: const Text('Log In'),
      ),
    );
  }
}
