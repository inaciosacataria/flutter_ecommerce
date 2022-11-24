// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:convert';
import 'package:ecommerce_int2/mainurl.dart';
import 'package:ecommerce_int2/screens/profile_page_content/extra_charges_admin.dart';
import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

import '../auth/InputDecorations.dart';

class ChangeCharges extends StatelessWidget {
  //TextController to read text entered in text field
  var service = new TextEditingController();

  var transFee = new TextEditingController();

  Future confirmRequest(BuildContext context) async {
    final MainUrl mu = MainUrl();
    var url1 = mu.getMainUrl();
    var url = url1 + "change_charges.php";
    Map postData = {
      'serviceC': service.text,
      'trans': transFee.text,
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ExtraChargesAdmin()));
            });
            return AlertDialog(
              title: Text('Changes Confirmed'),
            );
          });
    }
    print(data);
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Change Charges'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.only(top: 2),
            child: SingleChildScrollView(
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
                            controller: service,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                                Icons.money_rounded, "Service Charge"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Service Charge';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: transFee,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                                Icons.location_city_rounded, "Transaction Fee"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Transaction Fee';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: 200,
                          height: 80,
                          child: RaisedButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.blue[800],
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                confirmRequest(context);
                                print("successful");

                                return;
                              } else {
                                print("UnSuccessfull");
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            textColor: Colors.white,
                            child: Text(
                              "Confirm\nChanges",
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
          ),
        ),
      ),
    );
  }
}
