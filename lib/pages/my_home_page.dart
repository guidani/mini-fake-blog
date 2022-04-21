import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> posts = getPosts();

  static Future<List<Post>> getPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Post>(Post.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: posts,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              return const Text('Sem dados');
            }
          },
        ),
      ),
    );
  }

  Widget buildPosts(List<Post> posts) => ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: FlutterLogo(),
            ),
            title: Text(post.title),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/post-detail',
                arguments: Post(
                    id: posts[index].id,
                    body: posts[index].body,
                    userId: posts[index].userId,
                    title: posts[index].title),
              );
            },
          ),
        );
      });
}
