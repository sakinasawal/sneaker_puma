import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api-dev.treom.io";
  static const String accessToken = "64898|y2Gi9zjSXRHZpgo07X6TodNkkAQfPbCWjQYhOcupa282a666";
  static const String accept = "application/vnd.api+json";

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    developer.log("API CALL START: $url", name: "API");

    final response = await http.get(
      url,
      headers: {
        "Accept": accept,
        "Authorization": "Bearer $accessToken",
      },
    );
    return response;
  }
}