import '../mainurl.dart';
import "./products.dart";
import "package:http/http.dart" as http;

Future<List<Products>> fetchAllCartItems() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "get_cart_item.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());
  return productsFromJson(response.body);
}
