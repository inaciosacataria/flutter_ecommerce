import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/models/products.dart';
import 'package:ecommerce_int2/models/productsapi.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  List<Product> products;

  final SwiperController swiperController = SwiperController();
  final email;
  ProductList(this.email, {required this.products});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;

    return SizedBox(
      height: cardHeight,
      child: FutureBuilder(
        future: fetchAllProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Swiper(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                Products products = snapshot.data[index];
                return ProductCard(email,
                    height: cardHeight, width: cardWidth, product: products);
              },
              scale: 0.8,
              controller: swiperController,
              viewportFraction: 0.6,
              loop: false,
              fade: 0.5,
              pagination: SwiperCustomPagination(
                builder: (context, config) {
                  if (config!.itemCount! > 20) {
                    print(
                        "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
                  }
                  Color activeColor = mediumYellow;
                  Color color = Colors.grey.withOpacity(.3);
                  double size = 10.0;
                  double space = 5.0;

                  if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                      config.layout == SwiperLayout.DEFAULT) {
                    return new PageIndicator(
                      count: config.itemCount!,
                      controller: config.pageController!,
                      layout: config.indicatorLayout,
                      size: size,
                      activeColor: activeColor,
                      color: color,
                      space: space,
                    );
                  }

                  List<Widget> dots = [];

                  int itemCount = config.itemCount!;
                  int activeIndex = config.activeIndex!;

                  for (int i = 0; i < itemCount; ++i) {
                    bool active = i == activeIndex;
                    dots.add(Container(
                      key: Key("pagination_$i"),
                      margin: EdgeInsets.all(space),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active ? activeColor : color,
                          ),
                          width: size,
                          height: size,
                        ),
                      ),
                    ));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: dots,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;
  final double height;
  final double width;
  final email2;
  const ProductCard(
    this.email2, {
    required this.product,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductPage(email2, product: product))),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: mediumYellow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Colors.white,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(224, 69, 10, 1),
                        ),
                        child: Text(
                          '\$${product.price}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            child: Hero(
              tag: product.imgurl,
              child: Image.asset(
                product.imgurl,
                height: height / 1.7,
                width: width / 1.4,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
