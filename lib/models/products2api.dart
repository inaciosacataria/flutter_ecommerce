import '../mainurl.dart';
import "./products.dart";
import "package:http/http.dart" as http;

Future<List<Products>> fetchAllProducts2() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "product_list2.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());
  return productsFromJson(response.body);
}
