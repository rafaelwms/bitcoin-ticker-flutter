import 'package:http/http.dart' as http;
import 'dart:convert';

const String url_link = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = '?apikey=DD35A71D-CE6A-4BB7-BE73-0030BE2FEACF';

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future<String> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
