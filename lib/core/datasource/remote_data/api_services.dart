import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/apoi_config.dart';

class ApiServices {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    var url = Uri.https("${ApiConfig.baseUrl}", "/v2/$endpoint", {
      "apiKey": "${ApiConfig.apiKey}",
      ...?params,
    });
    print(url);
    try {
      final http.Response response = await http.get(url);
      // Map<String, dynamic> result =
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("failed to load Data: $e");
    }
  }
}
