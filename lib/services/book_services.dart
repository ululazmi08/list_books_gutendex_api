import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_palmcode/services/end_point.dart';

class BookServices {
  static Future dataListBooks(int page) async {
    print('dataListBooks Service');
    print('$baseUrl/books/?page=$page');
    var response = await http.get(
      Uri.parse('$baseUrl/books/?page=$page'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Data LIST BOOKS RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }
  static Future searchListBooks(int page,String text) async {
    print('searchListBooks Service');
    print('$baseUrl/books/?page=$page&search=$text');
    var response = await http.get(
      Uri.parse('$baseUrl/books/?page=$page&search=$text'),
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("SEARCH LIST BOOKS RES : " + response.body);
    if (response.statusCode != 200) return json.decode(response.body);
    return json.decode(response.body);
  }

}