import 'package:ecommerce_int2/screens/marketplace/ProductsMarketPlace.dart';
import 'package:ecommerce_int2/screens/profile_pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'SellProductUser.dart';

class MarketPlaceProducts extends StatelessWidget {
  static const routeName = "/MarketPlaceProducts";
  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(ProfilePage.routeName, arguments: email),
        ),
        title: Text(
          "MarketPlace Products",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Theme(
            data: ThemeData(canvasColor: Colors.white),
            child: DropdownButton(
                icon: Icon(Icons.more_vert, color: Colors.white),
                items: [
                  DropdownMenuItem(
                    value: 'SellProducts',
                    child: Row(
                      children: const [
                        Text(
                          "Sell your\nProduct",
                          overflow: TextOverflow.clip,
                        )
                      ],
                    ),
                  )
                ],
                onChanged: (itemIdentifier) {
                  if (itemIdentifier == 'SellProducts') {
                    Navigator.of(context).pushReplacementNamed(
                        SellProductUser.routeName,
                        arguments: email);
                  }
                }),
          )
        ],
      ),
      body: ProductMarketPlace(),
    );
  }
}
