import '../mainurl.dart';
import "./sell_item_data.dart";
import "package:http/http.dart" as http;

Future<List<Category1>> fetchAllCategory() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "categoryapi.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());

  var categories = categoryFromJson(response.body);
  print(categories);
  print(categories[1].category);
  print(response.body);
  return categoryFromJson(response.body);
}
