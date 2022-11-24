import '../mainurl.dart';
import "package:http/http.dart" as http;

import 'Seller.dart';

Future<List<Seller>> fetchAllSeller() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "sellerapi.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());

  return sellerFromJson(response.body);
}
