import 'dart:convert';
import 'dart:developer' as developer;
import '../../models/contract.dart';
import '../api_service.dart';

class ContractService {

  Future<List<Contract>> fetchContracts() async {
    try{
      final response = await ApiService.get("/v1/contracts?filter[document_type]=CONTRACT");
      developer.log("STATUS CODE: ${response.statusCode}", name: "API_RESPONSE");
      developer.log("BODY: ${response.body}", name: "API_RESPONSE");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];
        developer.log("PARSED ITEMS: ${list.length}", name: "API");

        return list.map((e) => Contract.fromJson(e)).toList();
      } else if (response.statusCode != 200){
        final body = jsonDecode(response.body);

        final message = body['errors']?[0]?['detail'] ?? body['message'] ?? 'Unknown error';

        developer.log("ERROR: $message", name: "API_ERROR");
        throw Exception(message);
      } else {
        developer.log(
          "REQUEST FAILED (${response.statusCode})",
          name: "API_ERROR",
        );

        throw Exception("Failed ${response.statusCode}");
      }

    } catch (e, stack){
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