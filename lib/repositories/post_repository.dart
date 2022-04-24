import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  // final String baseUrl = 'https://jsonplaceholder.typicode.com';
  List<Post> posts = [];

  Future<List<Post>> getPosts() async {
    try {
      var url = await Uri.https('jsonplaceholder.typicode.com', '/posts',
          {'_limit': '20', '_page': '1'});
      final response = await http.get(url);
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
      // posts.addAll(
      //   newItems.map<Post>(
      //     (post) => Post(
      //       body: post['body'],
      //       id: post['id'],
      //       title: post['title'],
      //       userId: post['userId'],
      //     ),
      //   ),
      // );

      return posts;
    } catch (error) {
      throw Exception(error);
    }
    return [];
  }
}
