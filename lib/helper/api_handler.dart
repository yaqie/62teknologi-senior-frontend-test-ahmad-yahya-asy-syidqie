import 'package:dio/dio.dart';
import 'package:enam_dua_teknologi/utils/const.dart';
import 'package:flutter/material.dart';

class Api {
  final dio = Dio();

  handler({url, queryParameters, body, method}) async {
    debugPrint(
        '================================================================');
    debugPrint('Request Server');
    debugPrint(
        '================================================================');
    debugPrint('URL : $url');
    debugPrint('queryParameters : $queryParameters');
    debugPrint('body : $body');

    return await dio.request(
      url,
      queryParameters: queryParameters,
      data: body,
      options: Options(
          headers: {
            "authorization": "Bearer $apiKey",
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          method: method),
    );
  }
}
