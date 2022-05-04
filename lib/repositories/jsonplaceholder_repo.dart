// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

class JsonplaceholderRepo {
  
  static Future getData(int currentPage) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_limit=15&_page=${currentPage}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('nada a declarar...');
    }
  }
}
