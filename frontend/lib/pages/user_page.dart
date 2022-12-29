import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String? urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            name,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: [
            Image.network(
              urlImage ?? 'http://jakubk.pl:2136/static/brakzdjecia.png',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Zmień awatar'),
            )
          ]),
        ));
  }
}
