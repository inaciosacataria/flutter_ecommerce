import 'package:ecommerce_int2/models/getMessages.dart';
import 'package:ecommerce_int2/screens/profile_pages/profile_page_seller.dart';
import 'package:flutter/material.dart';

import '../../models/getMessagesApi.dart';
import 'MessageDialogBox.dart';

class ShowMessagesDriver extends StatelessWidget {
  static const routeName = "/ShowMessagesDriver";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacementNamed(
              ProfilePageSeller.routeName,
              arguments: email),
        ),
        title: Text('Messages'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder(
                  future: getMessages(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            GetMessages message = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  message.fromEmail == "sarthak@k.com"
                                      ? "Admin"
                                      : message.fromEmail,
                                  style: TextStyle(fontSize: 20),
                                ),
                                leading: Icon(
                                  Icons.people,
                                ),
                              ),
                              ListTile(
                                title: Text("Message: ${message.msg}"),
                              ),
                              ElevatedButton(
                                  onPressed: () => showMessageDialog(context,
                                      from: email, to: message.fromEmail),
                                  child: Text("Reply")),
                              Divider(),
                            ]);
                          });
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Messages",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
