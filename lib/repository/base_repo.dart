import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tuple/tuple.dart';

import '../res/helpers/constants.dart';
import '../utils/shared_preferences/preferences.dart';

class BaseRepo {
  var token = Preferences.token;
  var sucursalId = Preferences.hotelId;
  var agenteId = Preferences.userId;
  final String baseUrl = apiUrl;
  bool finalPaginate = false;
  int timeOutMinutes = 2;

  Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future<List> getResponse(
    url, {
    String method = 'GET',
    String? body,
    String paramID = "",
    Tuple2<String, String> contentType = const Tuple2("image", "jpeg"),
    List<int>? file,
  }) async {
    Map<String, dynamic> responseMethod = {};
    try {
      var uri = Uri.parse('$baseUrl$url');
      var request;

      if (file == null) {
        request = http.Request(method, uri);
        request.headers.addAll(getHeaders());
        if (body != null) {
          request.body = body;
        }
      } else {
        request = http.MultipartRequest(method, uri);
        request.headers.addAll(getHeaders());

        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            file,
            filename: "file",
            contentType: MediaType(contentType.item1, contentType.item2),
          ),
        );

        if (paramID.isNotEmpty) {
          request.fields['_id'] = paramID;
        }
      }

      http.StreamedResponse response =
          await request.send().timeout(Duration(minutes: timeOutMinutes));
      var data = await response.stream.bytesToString();

      final Map<String, dynamic> decodedResp = json.decode(data);
      if (decodedResp.containsKey('data')) {
        data = json.encode(decodedResp['data']);
      }

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        responseMethod = {
          'status:': true,
          'data:': data,
          'failed_host': false,
          'code': response.statusCode,
        };
      } else {
        if (decodedResp.containsKey('errors')) {
          data = json.encode(decodedResp['errors']);
        }

        responseMethod = {
          'status:': false,
          'errors:': data,
          'failed_host': false,
          'code': response.statusCode,
        };
      }
    } catch (e) {
      responseMethod = {
        'status:': false,
        'data:': e.toString(),
        'failed_host': true,
        'code': 500,
      };
    }
    return responseMethod.values.toList();
  }
}
