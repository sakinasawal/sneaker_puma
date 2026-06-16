import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:sneaker_puma/data/api_service.dart';
import '../../models/operator.dart';

class OperatorService {
  Future<List<Operator>> fetchOperators({int page = 1, int size = 15}) async {
    final url = Uri.parse(
      "${ApiService.baseUrl}/v1/operators?page[size]=15&page[number]=1",
    );

    try {
      developer.log("API CALL START: $url", name: "API");

      final response = await http.get(
        url,
        headers: {
          "Accept": ApiService.accept,
          "Authorization": "Bearer ${ApiService.accessToken}",
        },
      );

      developer.log("STATUS CODE: ${response.statusCode}", name: "API");
      developer.log("HEADERS: ${response.headers}", name: "API");
      developer.log("BODY: ${response.body}", name: "API");

      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        final List list = data['data'];
        developer.log("PARSED ITEMS: ${list.length}", name: "API");
        return list.map((e) => Operator.fromJson(e)).toList();
      } else {
        developer.log(
          "FAILED RESPONSE: ${response.body}",
          name: "API_ERROR",
        );

        throw Exception(
          "Failed ${response.statusCode}",
        );
      }
    } catch (e, stack) {
      developer.log(
        "EXCEPTION OCCURRED",
        error: e,
        stackTrace: stack,
        name: "API_EXCEPTION",
      );

      rethrow;
    }
  }
}
