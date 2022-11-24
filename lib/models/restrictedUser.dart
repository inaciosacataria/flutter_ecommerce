import '../mainurl.dart';
import "package:http/http.dart" as http;

import 'Users.dart';

Future<List<Users>> fetchAllRestrictedUsers() async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "restricteduser.php";

  var response = await http.get(Uri.parse(url));
  print(response.body.toString());

  return usersFromJson(response.body);
}
