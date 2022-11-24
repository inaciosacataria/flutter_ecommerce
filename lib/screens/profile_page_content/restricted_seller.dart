import 'package:ecommerce_int2/models/Seller.dart';
import 'package:ecommerce_int2/models/restrictedSeller.dart';

import 'package:flutter/material.dart';

import '../profile_pages/profile_page_admin.dart';

class RestrictedSeller extends StatelessWidget {
  static const routeName = "/RestrictSeller";

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
        title: Text('Restricted Sellers'),
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
                  future: fetchAllRestrictedSellers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            Seller sellers = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(sellers.email),
                                leading: Icon(
                                  Icons.people,
                                ),
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
                            "No Restricted User!",
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
}
