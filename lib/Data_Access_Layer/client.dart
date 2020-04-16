import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HTTPClient {

  Future<dynamic> get (String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return Future.value(convert.jsonDecode(response.body));
    } else {
      return Future.error(Exception('bad or no connection.'));
    }
  }
}