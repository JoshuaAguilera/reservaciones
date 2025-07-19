import 'dart:convert';

import 'base_repo.dart';

class AuthRepo extends BaseRepo {
  // Method for get Token:  https://api.zaviaerp.com/pms/v1/token
  // Method for get Inventory:  ???

  Future<List> responseNW({
    required String route,
    String method = "POST",
    Map<String, dynamic>? bodyMap,
  }) async {
    try {
      String? body;
      if (bodyMap != null) {
        body = json.encode(bodyMap);
      }

      List responseGet = await getResponse(
        route,
        method: method,
        body: body,
      );
      return responseGet;
    } catch (e) {
      print(e);
    }
    return List.empty();
  }
}
