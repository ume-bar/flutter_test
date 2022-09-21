import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_flutter/env.dart';

final Map<String, String> postHeader = {
  'X-Cybozu-API-Token': apiToken!,
  'Content-Type': 'application/json'
};

final Map<String, String> getHeader = {
  'X-Cybozu-API-Token': apiToken!,
};

Future<Map<String, dynamic>> postRecord(int number) async {
  final Map<String, dynamic> postRecord = {
    'app': id,
    'record': {
      'number': {'value': number},
    }
  };

  return await http
      .post(Uri.parse('$baseUrl/record.json'),
          headers: postHeader, body: jsonEncode(postRecord))
      .then(((response) {
    Map<String, dynamic> rec = jsonDecode(response.body);
    return rec;
  }));
}

Future<Map<String, dynamic>> fetchRecords(String query) async {
  String encodedQuery = Uri.encodeFull(query);
  return await http
      .get(
          Uri.parse(
            '$baseUrl/records.json?app=$id&query=$encodedQuery',
          ),
          headers: getHeader)
      .then(((response) {
    Map<String, dynamic> rec = jsonDecode(response.body);
    return rec;
  }));
}
