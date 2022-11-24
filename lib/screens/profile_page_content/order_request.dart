import 'dart:convert';
import 'package:ecommerce_int2/models/orderDetails.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:location/location.dart';

import '../../mainurl.dart';
import 'MessageDialogBox.dart';

class OrderRequest extends StatefulWidget {
  static const routeName = "/OrderRequests";

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  var email;
  double lat = 0.0;
  double lng = 0.0;
  LocationData? currentLocation;

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getCurrentLocation();
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      if (lat != currentLocation!.latitude! &&
          lng != currentLocation!.longitude!) {
        lat = currentLocation!.latitude!;
        lng = currentLocation!.longitude!;
        updateLocation(lat, lng, email);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Orders'),
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
                                    request.shopName,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  leading: Icon(
                                    Icons.add_box,
                                  ),
                                ),
                                ListTile(
                                  title: Text("Order ID: ${request.id}"),
                                ),
                                ListTile(
                                  title: Text(
                                      "Product Name: ${request.productName}"),
                                ),
                                ListTile(
                                  title: Text("User: ${request.user}"),
                                ),
                                ListTile(
                                  title:
                                      Text("User Phone: ${request.userPhone}"),
                                ),
                                ListTile(
                                  title: Text(
                                      "Seller Phone: ${request.sellerPhone}"),
                                ),
                                ListTile(
                                  title: Text(
                                      "Shop Address: ${request.shopAddress}"),
                                ),
                                ListTile(
                                  title: Text(
                                      "User Address: ${request.userAddress}"),
                                ),
                                ElevatedButton(
                                    onPressed: () => showMessageDialog(context,
                                        from: email, to: request.user),
                                    child: Text("Message User")),
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
                            "No Order Requests!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                    return Center(
                      child: Text(
                        "Waiting for\nOrders",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateLocation(double lat, double lng, String email) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "update_location_driver.php";
    Map postData = {
      'lat': lat.toString(),
      'lng': lng.toString(),
      'email': email
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());
    var data = jsonDecode(response.body);
    if (data == "done") {
      print("success");
    }
  }

  Future<List<OrderDetails>?> postEmail(String email) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "fetch_order.php";
    Map postData = {
      'email': email,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());
    var data = jsonDecode(response.body);
    // if (data == "noorder") {
    //   return null;
    // }

    return orderDetailsFromJson(response.body);
  }
}
