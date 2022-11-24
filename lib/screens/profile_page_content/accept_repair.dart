// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:convert';
import 'package:ecommerce_int2/mainurl.dart';
import 'package:ecommerce_int2/screens/profile_page_content/pending_requests.dart';

import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

import '../auth/InputDecorations.dart';

class RepairRequestAccept extends StatelessWidget {
  static const routeName = "/RepairRequestAccept";

  String phone = "";

  //TextController to read text entered in text field
  var phone1 = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    String user = arguments[0];
    String seller = arguments[1];
    String service = arguments[2];
    String rid = arguments[3];
    String address = arguments[4];
    String issue = arguments[5];
    String date = arguments[6];
    String time = arguments[7];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Fix Appointment'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: TextFormField(
                              controller: phone1,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration(
                                  Icons.phone, "Mechanic Phone"),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Please Enter Valid Phone Number';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                phone = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 70,
                            child: RaisedButton(
                              color: Colors.blue[800],
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  confirmAppointment(user, seller, service, rid,
                                      address, issue, date, time, context);
                                  print("successful");

                                  return;
                                } else {
                                  print("UnSuccessfull");
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side:
                                      BorderSide(color: Colors.blue, width: 2)),
                              textColor: Colors.white,
                              child: Text(
                                "Confirm\nAppointment",
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future confirmAppointment(
      String user,
      String seller,
      String service,
      String rid,
      String address,
      String issue,
      String date,
      String time,
      BuildContext context) async {
    final MainUrl mu = MainUrl();
    var url1 = mu.getMainUrl();
    var url = url1 + "confirm_appointment.php";
    Map postData = {
      'user': user,
      'date': date,
      'time': time,
      'seller': seller,
      'service': service,
      'address': address,
      'issue': issue,
      'rid': rid,
      'phone': phone1.text
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
              Navigator.of(context).pushReplacementNamed(
                  PendingRequest.routeName,
                  arguments: seller);
            });
            return AlertDialog(
              title: Text('Appointment Confirmed'),
            );
          });
    }
    print(data);
  }
}
