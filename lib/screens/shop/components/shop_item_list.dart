import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/products.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:ecommerce_int2/screens/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ShopItemList extends StatefulWidget {
  final Products product;
  final service;
  final gst;
  final transFee;
  final total;
  final VoidCallback onRemove;

  ShopItemList(this.product, this.service, this.gst, this.transFee, this.total,
      {required this.onRemove});

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: expanded ? 250 : 130,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment(0, 0.9),
              child: Column(
                children: [
                  Container(
                      height: 118,
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 12.0, right: 12.0),
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.product.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: darkGrey,
                                    ),
                                    softWrap: true,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ColorOption(Colors.red),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              expanded = !expanded;
                                            }),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '\u{20B9}${widget.total}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: darkGrey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17.0),
                                                ),
                                                Icon(Icons.arrow_drop_down),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Theme(
                              data: ThemeData(
                                  textTheme: TextTheme(
                                    headline6: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    bodyText1: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(secondary: Colors.black)),
                              child: NumberPicker(
                                value: quantity,
                                minValue: 1,
                                maxValue: 10,
                                onChanged: (value) {
                                  setState(() {
                                    quantity = value;
                                  });
                                },
                                axis: Axis.vertical,
                                itemWidth: 20,
                              ),
                            )
                          ])),
                  if (expanded)
                    Container(
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service charge:"),
                              Text(widget.service),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("GST:"),
                              Text(widget.gst.toStringAsFixed(2)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transaction Fee:"),
                              Text(widget.transFee.toStringAsFixed(2)),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total:"),
                              Text(widget.total.toString()),
                            ],
                          )
                        ],
                      ),
                    )
                ],
              )),
          Positioned(
              top: 5,
              child: ShopProductDisplay(
                widget.product,
                onPressed: widget.onRemove,
              )),
        ],
      ),
    );
  }
}
