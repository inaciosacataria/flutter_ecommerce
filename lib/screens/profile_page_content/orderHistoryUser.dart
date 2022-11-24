import 'dart:convert';
import 'package:ecommerce_int2/screens/profile_pages/profile_page.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../../mainurl.dart';
import '../../models/orderDetails.dart';

class OrderHistroyUser extends StatelessWidget {
  static const routeName = "/OrderHistoryUser";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(ProfilePage.routeName, arguments: email),
        ),
        title: Text('Order History'),
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
                            OrderDetails request = snapshot.data[index];

                            return SingleChildScrollView(
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text(
                                    request.productName,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  leading: Icon(
                                    Icons.add_box,
                                  ),
                                ),
                                ListTile(
                                  title: Text("Seller: ${request.seller}"),
                                ),
                                ListTile(
                                  title: Text(
                                      "Total Amount: \u{20B9} ${request.totalAmount}"),
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

  Future<List<OrderDetails>> postEmail(String email) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "fetch_order_user.php";
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

    return orderDetailsFromJson(response.body);
  }
}
