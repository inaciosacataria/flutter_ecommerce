import 'package:ecommerce_int2/models/Seller.dart';

import '../mainurl.dart';
import "package:http/http.dart" as http;

Future<List<Seller>> fetchAllRestrictedSellers() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "restrictedseller.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());

  return sellerFromJson(response.body);
}
