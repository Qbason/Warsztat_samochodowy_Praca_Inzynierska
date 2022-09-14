// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:first_project/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String title;
  final String content;
  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  initState() {
    controller.text = widget.title;
    controller2.text = widget.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
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
                widget.client.put(updateurlNote(widget.id), body: {
                  'title': controller.text,
                  'content': controller2.text,
                });
                Navigator.pop(context);
              },
              child: const Text("Update Note"))
        ],
      ),
    );
  }
}
