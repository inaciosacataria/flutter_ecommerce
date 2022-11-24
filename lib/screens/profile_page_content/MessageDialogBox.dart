import 'dart:convert';

import 'package:ecommerce_int2/mainurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'restrict_user.dart';

Future<T?> showMessageDialog<T>(
  BuildContext context, {
  required String from,
  required String to,
}) =>
    showDialog(
        context: context,
        builder: (context) => MessageDialogBox(
              from: from,
              to: to,
            ));

class MessageDialogBox extends StatefulWidget {
  final String from;
  final String to;

  MessageDialogBox({
    Key? key,
    required this.from,
    required this.to,
  }) : super(key: key);

  @override
  State<MessageDialogBox> createState() => _MessageDialogBoxState();
}

class _MessageDialogBoxState extends State<MessageDialogBox> {
  Future confirmRequest(BuildContext context) async {
    final MainUrl mu = MainUrl();
    var url1 = mu.getMainUrl();
    var url = url1 + "send_message.php";
    Map postData = {
      'from': widget.from,
      'to': widget.to,
      'msg': controller.text,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());
    var data = jsonDecode(response.body);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
              controller.clear();
            });
            return AlertDialog(
              title: Text('Message sent'),
            );
          });
    }
    print(data);
  }

  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Send Message"),
      content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          )),
      actions: [
        ElevatedButton(
            onPressed: () => confirmRequest(context),
            child: Text(
              "Send",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
