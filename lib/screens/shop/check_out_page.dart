import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/mainurl.dart';
import 'package:ecommerce_int2/models/getExtraCharges.dart';

import 'package:ecommerce_int2/models/products.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'components/credit_card.dart';
import 'components/shop_item_list.dart';

class CheckOutPage extends StatefulWidget {
  Map<String, double> grandTotal = {'gh': 0.0};
  static const routeName = "/CheckOutPage";
  final email;

  CheckOutPage(this.email);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  SwiperController swiperController = SwiperController();

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
    final email = ModalRoute.of(context)?.settings.arguments as String;

    Widget checkOutButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Check Out",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );
    Future<List<Products>?> postEmail() async {
      final MainUrl mu = MainUrl();
      String url1 = mu.getMainUrl();
      var url = url1 + "get_cart_item.php";
      Map postData = {
        'email': email,
      };
      var response = await http.post(Uri.parse(url), body: postData);
      var data = jsonDecode(response.body);

      return productsFromJson(response.body);
    }

    void removeFromCart(String email, String pid) async {
      final MainUrl mu = MainUrl();
      String url1 = mu.getMainUrl();
      var url = url1 + "remove_from_cart.php";
      Map postData = {
        'email': email,
        'pid': pid,
      };
      var response = await http.post(Uri.parse(url), body: postData);
      setState(() {
        widget.grandTotal.remove(pid);
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(MainPage.routeName, arguments: email),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/denied_wallet.png'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
          )
        ],
        title: Text(
          'Checkout',
          style: TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: FutureBuilder<List<GetExtraCharges>>(
              future: getExtraCharges(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
                GetExtraCharges charges = snapshot1.data![0];

                return FutureBuilder(
                  future: postEmail(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                            height: 48.0,
                            color: yellow,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  snapshot.data.length.toString() + ' items',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Scrollbar(
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  final price =
                                      double.parse(snapshot.data![index].price);
                                  final service =
                                      double.parse(charges.serviceCharge)
                                          .toStringAsFixed(2);
                                  final gst = price *
                                      (double.parse(snapshot.data![index].gst) /
                                          100);
                                  final transFee = price *
                                      (double.parse(charges.transactionFee) /
                                          100);
                                  final total1 = (price + gst + transFee + 50);
                                  if (!widget.grandTotal
                                      .containsKey(snapshot.data[index].pid))
                                    widget.grandTotal.addAll(
                                        {snapshot.data[index].pid: total1});
                                  final total = total1.toStringAsFixed(2);
                                  print((widget.grandTotal.values.reduce(
                                      (sum, element) => sum + element)));
                                  print(widget.grandTotal);
                                  return ShopItemList(
                                    snapshot.data[index],
                                    service,
                                    gst,
                                    transFee,
                                    total,
                                    onRemove: () => removeFromCart(
                                        email, snapshot.data[index].pid),
                                  );
                                },
                                itemCount: snapshot.data.length,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Grand Total:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  (widget.grandTotal.values.reduce(
                                          (sum, element) => sum + element))
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Payment',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: darkGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            child: Swiper(
                              itemCount: 2,
                              itemBuilder: (_, index) {
                                return CreditCard();
                              },
                              scale: 0.8,
                              controller: swiperController,
                              viewportFraction: 0.6,
                              loop: false,
                              fade: 0.7,
                            ),
                          ),
                          SizedBox(height: 24),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).padding.bottom ==
                                        0
                                    ? 20
                                    : MediaQuery.of(context).padding.bottom),
                            child: checkOutButton,
                          ))
                        ],
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
