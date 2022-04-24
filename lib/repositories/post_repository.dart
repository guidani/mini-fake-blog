import 'dart:convert';
import 'package:http/http.dart';

import '../models/post_model.dart';

class PostRepository {
  final Client _httpClient;

  PostRepository(this._httpClient);

  Future<List<Post>> getPosts() async {
    try {
      var url = Uri.https('jsonplaceholder.typicode.com', '/posts',
          {'_limit': '20', '_page': '1'});
      final response = await _httpClient.get(url);
      final newItems = jsonDecode(response.body);
      return (newItems as List)
          .map<Post>(
            (post) => Post(
              body: post['body'],
              id: post['id'],
              title: post['title'],
              userId: post['userId'],
            ),
          )
          .toList();
    } catch (error) {
      throw Exception(error);
    }
  }
}
