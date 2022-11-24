import '../mainurl.dart';

import "package:http/http.dart" as http;

import 'UserSoldProducts.dart';

Future<List<ProductsUser>> fetchAllProductsUser() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "user_products_list.php";
  var response = await http.get(Uri.parse(url));
  print(response.body.toString());
  return productsUserFromJson(response.body);
}
