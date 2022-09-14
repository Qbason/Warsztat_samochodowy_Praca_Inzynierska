// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:first_project/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 1,
          ),
          TextField(
            controller: controller2,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(createurlNote(), body: {
                  'title': controller.text,
                  'content': controller2.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Create Note"))
        ],
      ),
    );
  }
}
