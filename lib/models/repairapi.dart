import 'package:ecommerce_int2/models/services.dart';

import '../mainurl.dart';

import "package:http/http.dart" as http;

Future<List<RepairApi>> fetchAllServices() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "repairapi.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());
  return repairApiFromJson(response.body);
}
