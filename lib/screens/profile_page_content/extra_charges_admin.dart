import 'package:ecommerce_int2/mainurl.dart';
import 'package:ecommerce_int2/models/Seller.dart';
import 'package:ecommerce_int2/models/getExtraCharges.dart';
import 'package:ecommerce_int2/models/sellerapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'TextDialogWidget.dart';
import 'change_charges.dart';

class ExtraChargesAdmin extends StatelessWidget {
  Future<List<GetExtraCharges>> getExtraCharges() async {
    final MainUrl mu = MainUrl();
    var url1 = mu.getMainUrl();
    var url = url1 + "get_extra_charges.php";
    var response = await http.get(Uri.parse(url));
    print(response.body.toString());
    return getExtraChargesFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Extra Charges'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder<List<GetExtraCharges>>(
                  future: getExtraCharges(),
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
                            GetExtraCharges charges = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  'Service Charge',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '\u{20B9} ${charges.serviceCharge}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                leading: Icon(
                                  Icons.money,
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 10, right: 10),
                                child: Text("GST",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 10, right: 10),
                                height: 150,
                                child: FutureBuilder(
                                    future: fetchAllSeller(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading...");
                                      }
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(12),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            Seller seller =
                                                snapshot.data[index];
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${seller.id}. ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                  softWrap: true,
                                                ),
                                                Text(
                                                  '${seller.shopName} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                  softWrap: true,
                                                ),
                                                Text(
                                                  '${seller.gst} %',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                GestureDetector(
                                                    onTap: () => showTextDialog(
                                                          context,
                                                          title:
                                                              "Change GST(${seller.shopName})",
                                                          value: seller.gst,
                                                          id: seller.id,
                                                        ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 30,
                                                    )),
                                              ],
                                            );
                                          });
                                    }),
                              ),
                              Divider(),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 10, right: 10),
                                  child: ElevatedButton(
                                    child: Text(
                                      "Change GST for All",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () => showTextDialog(
                                      context,
                                      title: "Change GST for All",
                                      value: "0",
                                      id: "0",
                                    ),
                                  )),
                              Divider(),
                              ListTile(
                                title: Text(
                                  'Transaction Charge',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${charges.transactionFee} %',
                                  style: TextStyle(fontSize: 15),
                                ),
                                leading: Icon(
                                  Icons.money,
                                ),
                              ),
                              Divider(),
                            ]);
                          });
                    }
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 200,
                height: 70,
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => ChangeCharges())),
                    child: Text('Change',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
