import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/Seller.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/sellerapi.dart';
import 'package:ecommerce_int2/screens/category/components/staggered_card2.dart';
import 'package:flutter/material.dart';

class ShopListPage extends StatefulWidget {
  final email2;
  ShopListPage(this.email2);
  @override
  _ShopListPageState createState() => _ShopListPageState(email2);
}

class _ShopListPageState extends State<ShopListPage> {
  final email;
  _ShopListPageState(this.email);
  List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Shops List',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: fetchAllSeller(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          Seller sellerItem = snapshot.data[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: StaggeredCardCard2(email,
                                begin: Colors.purple,
                                end: Colors.purple,
                                categoryName: sellerItem.shopName,
                                assetPath: 'assets/icons/shop.png',
                                sellerId: sellerItem.id),
                          );
                        });
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
