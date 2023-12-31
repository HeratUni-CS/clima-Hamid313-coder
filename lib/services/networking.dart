import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  NetworkService(this.path);

  final String path;

  Future getData() async {
    http.Response response = await http.get(path);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}
