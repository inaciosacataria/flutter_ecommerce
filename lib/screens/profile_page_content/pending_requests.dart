import 'dart:convert';
import 'package:ecommerce_int2/models/pendingRequests.dart';
import 'package:ecommerce_int2/screens/profile_page_content/TextDialogWidget.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../../mainurl.dart';
import '../profile_pages/profile_page_seller.dart';
import 'accept_repair.dart';

class PendingRequest extends StatelessWidget {
  static const routeName = "/PendingRequests";

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
        title: Text('Pending Requests'),
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
                  future: postEmail(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            PendingRequests request = snapshot.data[index];

                            return SingleChildScrollView(
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text(
                                    request.service,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  leading: Icon(
                                    Icons.people,
                                  ),
                                ),
                                ListTile(
                                  title: Text("Issue: ${request.issue}"),
                                ),
                                ListTile(
                                  title: Text("User: ${request.user}"),
                                ),
                                ListTile(
                                  title: Text("State: ${request.state}"),
                                ),
                                ListTile(
                                  title: Text("City: ${request.city}"),
                                ),
                                ListTile(
                                  title: Text("Locality: ${request.locality}"),
                                ),
                                ListTile(
                                  title: Text("Landmark: ${request.landmark}"),
                                ),
                                ListTile(
                                  title: Text("Address: ${request.address}"),
                                ),
                                ListTile(
                                  title: Text("Phone: ${request.phone}"),
                                ),
                                ListTile(
                                  title: Text(
                                    "Timeslot: ${request.timeslot}",
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () => showTextDialog(context,
                                          title: "Change Timeslot",
                                          value: request.timeslot,
                                          id: "time",
                                          rid: request.rid,
                                          seller: request.seller),
                                      child: Icon(Icons.edit)),
                                ),
                                ListTile(
                                  title: Text(
                                    "Date: ${request.date}",
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () => showTextDialog(context,
                                          title: "Change Date",
                                          value: request.date,
                                          id: "date",
                                          rid: request.rid,
                                          seller: request.seller),
                                      child: Icon(Icons.edit)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  RepairRequestAccept.routeName,
                                                  arguments: [
                                                request.user,
                                                request.seller,
                                                request.service,
                                                request.rid,
                                                request.address,
                                                request.issue,
                                                request.date,
                                                request.timeslot
                                              ]);
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          rejectRepair(request.rid);
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ProfilePageSeller.routeName,
                                                  arguments: request.seller);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                Divider(),
                              ]),
                            );
                          });
                    } else {
                      Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Pending Requests!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                    return CircularProgressIndicator.adaptive();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future rejectRepair(String rid) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "reject_request.php";
    Map postData = {
      'rid': rid,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());
    var data = jsonDecode(response.body);
    if (data == "success") {
      print("success");
    }
  }

  Future<List<PendingRequests>> postEmail(String email) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "pendingrequests.php";
    Map postData = {
      'email': email,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());
    var data = jsonDecode(response.body);
    if (data == "success") {
      print("success");
    }

    return pendingRequestsFromJson(response.body);
  }
}
