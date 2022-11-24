import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/products.dart';
import 'package:ecommerce_int2/models/productsapi.dart';
import 'package:ecommerce_int2/screens/product/components/product_card.dart';
import 'package:flutter/material.dart';

class MoreProducts extends StatefulWidget {
  @override
  State<MoreProducts> createState() => _MoreProductsState();
}

class _MoreProductsState extends State<MoreProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'More products',
            style: TextStyle(color: Colors.white, shadows: shadow),
          ),
        ),
        FutureBuilder(
          future: fetchAllProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(bottom: 20.0),
                height: 250,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    Products products = snapshot.data[index];
                    return Padding(

                        ///calculates the left and right margins
                        ///to be even with the screen margin
                        padding: index == 0
                            ? EdgeInsets.only(left: 24.0, right: 8.0)
                            : index == 4
                                ? EdgeInsets.only(right: 24.0, left: 8.0)
                                : EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCard(products));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              );
            }
            return CircularProgressIndicator.adaptive();
          },
        )
      ],
    );
  }
}
