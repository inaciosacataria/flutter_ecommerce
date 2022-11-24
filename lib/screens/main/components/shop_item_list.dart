import 'dart:convert';

import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/products.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../mainurl.dart';

class ShopList extends StatefulWidget {
  static const routeName = "/ShopList";

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final sellerId = arguments[0];
    final email = arguments[1];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login1.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 26,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                      width: 4,
                      color: mediumYellow,
                    ),
                  ),
                  Center(
                      child: Text(
                    'Shop Products',
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder(
                  future: shopListApi(sellerId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Container(
                        padding:
                            EdgeInsets.only(top: 22.0, right: 16.0, left: 16.0),
                        child: StaggeredGridView.countBuilder(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 4,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              new ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ProductPage(email,
                                          product: snapshot.data[index]))),
                              child: Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                        colors: [
                                          Colors.grey.withOpacity(0.3),
                                          Colors.grey.withOpacity(0.7),
                                        ],
                                        center: Alignment(0, 0),
                                        radius: 0.6,
                                        focal: Alignment(0, 0),
                                        focalRadius: 0.1),
                                  ),
                                  child: Hero(
                                      tag: snapshot.data[index].imgurl,
                                      child: Image.asset(
                                          snapshot.data[index].imgurl))),
                            ),
                          ),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(2, index.isEven ? 3 : 2),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      );
                    }
                    return CircularProgressIndicator.adaptive();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Products>> shopListApi(String sellerId) async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "shopitemlistapi.php";

    Map postData = {
      'sellerid': sellerId,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);

    print(response.body.toString());
    var data = jsonDecode(response.body);

    print(data);
    return productsFromJson(response.body);
  }
}
