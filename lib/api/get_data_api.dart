import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> fetchData(String query) async {
  Map<String, dynamic>? data;
  final response = await http
      .get(Uri.parse('https://api.adviceslip.com/advice/search/$query'));

  if (response.statusCode == 200) {
    data = jsonDecode(response.body);
  } else {
    print('ERRO ON GET HTTP');
  }

  return data;
}
