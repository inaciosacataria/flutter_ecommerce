import 'package:ecommerce_int2/screens/profile_pages/profile_page.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../../mainurl.dart';
import '../../models/appointmentsUser.dart';

class AppointmentUser extends StatelessWidget {
  static const routeName = "/AppointmentsUser";

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
        title: Text('Appointments'),
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
                  future: getAppointments(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            AppointmentsUser appointments =
                                snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  appointments.service,
                                  style: TextStyle(fontSize: 20),
                                ),
                                leading: Icon(
                                  Icons.people,
                                ),
                              ),
                              ListTile(
                                title: Text("Seller: ${appointments.seller}"),
                              ),
                              ListTile(
                                title: Text("Issue: ${appointments.issue}"),
                              ),
                              ListTile(
                                title: Text("Address: ${appointments.address}"),
                              ),
                              ListTile(
                                title: Text("Date: ${appointments.date}"),
                              ),
                              ListTile(
                                title: Text("Time: ${appointments.time}"),
                              ),
                              ListTile(
                                title: Text(
                                    "Mechanic Phone: ${appointments.mechanicPhone}"),
                              ),
                              Divider(),
                            ]);
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

  Future<List<AppointmentsUser>> getAppointments(String email) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "appointments_user.php";
    Map postData = {
      'email': email,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    print(response.body.toString());

    return appointmentsUserFromJson(response.body);
  }
}
