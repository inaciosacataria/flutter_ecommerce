// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:convert';
import 'package:ecommerce_int2/mainurl.dart';

import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

import '../auth/InputDecorations.dart';
import '../profile_pages/profile_page.dart';

class RepairRequest extends StatefulWidget {
  static const routeName = "/RepairRequest";

  @override
  State<RepairRequest> createState() => _RepairRequestState();
}

class _RepairRequestState extends State<RepairRequest> {
  String address = "",
      phone = "",
      issue = "",
      state = "",
      city = "",
      locality = "",
      landmark = "";

  String? category = "none";

  List<String> itemlist2 = [
    "10 PM - 12 PM",
    "12 PM - 2 PM",
    "2 PM - 4 PM",
    "4 PM - 6 PM",
    "6 PM - 8 PM"
  ];

  //TextController to read text entered in text field
  var address1 = new TextEditingController();

  var phone1 = new TextEditingController();

  var issue1 = new TextEditingController();

  var state1 = new TextEditingController();

  var city1 = new TextEditingController();

  var locality1 = new TextEditingController();

  var landmark1 = new TextEditingController();

  var date = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    String email = arguments[0];
    String sellerId = arguments[1];
    String service = arguments[2];
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black)));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Repair Request'),
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
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: issue1,
                            keyboardType: TextInputType.text,
                            decoration:
                                buildInputDecoration(Icons.settings, "Issue"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Issue';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              issue = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: address1,
                            keyboardType: TextInputType.text,
                            decoration:
                                buildInputDecoration(Icons.home, "Address"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Address';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              address = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: state1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_rounded, "State"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter State';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              state = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: city1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_outlined, "City"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter City';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              city = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: locality1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_sharp, "Locality"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Locality';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              locality = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: landmark1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city, "Landmark"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Landmark';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              landmark = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: phone1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.phone, "Phone Number"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Phone Number';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              phone = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: date,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.phone, "Date (DD-MM-YYYY)"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Date';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: DropdownButtonFormField<String>(
                            hint: Text("select Preffered Timeslot"),
                            dropdownColor: Colors.blue[100],
                            elevation: 5,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.blue))),
                            items: itemlist2.map(buildMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => category = value),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.blue[800],
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                confirmRequest(
                                    email, sellerId, service, context);
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
                              "Confirm\nRequest",
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

  Future confirmRequest(String email, String sellerId, String service,
      BuildContext context) async {
    final MainUrl mu = MainUrl();
    var url1 = mu.getMainUrl();
    var url = url1 + "repair_request.php";
    Map postData = {
      'email': email,
      'address': address1.text,
      'phone': phone1.text,
      'issue': issue1.text,
      'sellerId': sellerId,
      'service': service,
      'state': state1.text,
      'city': city1.text,
      'locality': locality1.text,
      'landmark': landmark1.text,
      'timeslot': category,
      'date': date.text,
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
              Navigator.of(context).pushReplacementNamed(ProfilePage.routeName,
                  arguments: email);
            });
            return AlertDialog(
              title: Text('Request Confirmed'),
            );
          });
    }
    print(data);
  }
}
