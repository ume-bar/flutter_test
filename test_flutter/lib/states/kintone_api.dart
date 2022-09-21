import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:test_flutter/env.dart';

Future<Map<String, dynamic>> postRecord(int number) async {
  final dio = Dio();
  final Map<String, dynamic> postRecord = {
    'app': id,
    'record': {
      'number': {'value': number},
    }
  };
  return await dio
      .post(
    '$baseUrl/record.json',
    data: jsonEncode(postRecord),
    options: Options(
      headers: {
        'X-Cybozu-API-Token': apiToken!,
        'Content-Type': 'application/json',
      },
    ),
  )
      .then(((response) {
    Map<String, dynamic> rec = jsonDecode(response.data);
    return rec;
  }));
}

Future<Map<String, dynamic>> fetchRecords(String query) async {
  final dio = Dio();
  String encodedQuery = Uri.encodeFull(query);
  return await dio
      .get('$baseUrl/records.json?app=$id&query=$encodedQuery',
          options: Options(headers: {
            'X-Cybozu-API-Token': apiToken!,
          }))
      .then(((response) {
    Map<String, dynamic> rec = jsonDecode(response.data);
    return rec;
  }));
}
