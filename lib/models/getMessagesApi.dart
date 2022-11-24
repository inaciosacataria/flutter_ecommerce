import 'package:ecommerce_int2/models/getMessages.dart';
import 'package:http/http.dart' as http;
import '../mainurl.dart';

Future<List<GetMessages>> getMessages(String email) async {
  final MainUrl mu = MainUrl();
  String url1 = mu.getMainUrl();
  var url = url1 + "get_message.php";
  Map postData = {
    'email': email,
  };
  print(postData);
  var response = await http.post(Uri.parse(url), body: postData);
  print(response.body.toString());

  return getMessagesFromJson(response.body);
}
