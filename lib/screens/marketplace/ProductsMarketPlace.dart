import 'dart:convert';

import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:ecommerce_int2/screens/product/product_page_user.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../mainurl.dart';
import '../../models/UserSoldProducts.dart';

class ProductMarketPlace extends StatelessWidget {
  static const routeName = "/ProductMarketPlace";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login1.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: FutureBuilder(
                  future: productListApi(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
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
                                      builder: (_) => ProductPageUser(email,
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
                    return Center(
                        child: Text(
                      "No products",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ProductsUser>> productListApi() async {
    final MainUrl mu = MainUrl();
    String url1 = mu.getMainUrl();
    var url = url1 + "user_products_list.php";

    var response = await http.get(Uri.parse(url));

    print(response.body.toString());
    var data = jsonDecode(response.body);

    print(data);
    return productsUserFromJson(response.body);
  }
}
