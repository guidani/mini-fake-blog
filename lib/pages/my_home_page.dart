import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random random = Random();
  final _controller = ScrollController();
  List<Post> posts = [];
  // TODO: receber o page como argumento
  int page = 1;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    getPosts();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        getPosts();
      }
    });
  }

  Future getPosts() async {
    const limit = 15;
    final url =
        'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List newItems = jsonDecode(response.body);
      setState(() {
        page++;
        if (newItems.length < limit) {
          hasMore = false;
        }
        posts.addAll(
          newItems.map<Post>((post) => Post(
              body: post['body'],
              id: post['id'],
              title: post['title'],
              userId: post['userId'])),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('>>>>>>>>>>>>>>>>>> Current page ${page}');
    return Scaffold(
      body: Center(
        child: buildPosts(posts),
      ),
    );
  }

  Widget buildPosts(List<Post> posts) => ListView.builder(
        controller: _controller,
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index < posts.length) {
            final post = posts[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/peopleImages/${random.nextInt(21)}.jpg'),

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
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: hasMore ? const CircularProgressIndicator() : null,
              ),
            );
          }
        },
      );
}
