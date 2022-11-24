import 'dart:convert';

import 'package:ecommerce_int2/models/Users.dart';

import 'package:ecommerce_int2/models/userapi.dart';
import 'package:ecommerce_int2/screens/profile_page_content/MessageDialogBox.dart';
import 'package:ecommerce_int2/screens/profile_pages/profile_page_admin.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../mainurl.dart';

class RestrictUser extends StatelessWidget {
  static const routeName = "/RestrictUser";

  String button = "";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacementNamed(
              ProfilePageAdmin.routeName,
              arguments: email),
        ),
        title: Text('All Users'),
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
                  future: fetchAllUsers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            Users users = snapshot.data[index];
                            String change = "0";
                            if (users.isRestrict == "0") {
                              change = "1";
                              button = "Restrict";
                            } else {
                              button = "Unrestrict";
                            }
                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(users.email),
                                leading: Image.asset(
                                  'assets/icons/settings_icon.png',
                                  fit: BoxFit.scaleDown,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        restrictUser(
                                            users.email, change, context);
                                      },
                                      child: Text(
                                        button,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  ElevatedButton(
                                      onPressed: () => showMessageDialog(
                                          context,
                                          from: email,
                                          to: users.email),
                                      child: Text(
                                        "Message",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              Divider(),
                            ]);
                          });
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

  Future restrictUser(String email, String change, BuildContext context) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "restrictuser.php";

    Map postData = {
      'email': email,
      'restrict': change,
    };
    String msg = "";
    if (change == "1") {
      msg = "User is restricted!";
    } else {
      msg = "User is unrestricted!";
    }
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    var data = jsonDecode(response.body);
    if (data == "done") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context)
                  .pushReplacementNamed(RestrictUser.routeName);
            });
            return AlertDialog(
              title: Text(msg),
            );
          });
    } else if (data == "notdone") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2));
            return AlertDialog(
              title: Text('Some error occured'),
            );
          });
    }

    print(data);
  }
}
