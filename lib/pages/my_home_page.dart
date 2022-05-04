import 'dart:convert';
import 'dart:math';

import 'package:fetch_users_01/controllers/placeholder_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final placeholderController = PlaceholderController();
  final _controller = ScrollController();
  List<Post> posts = [];
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
    print('Page dentro do getPosts >>> $page');
    // await PlaceholderController.init(page);
    // List<Post> resultFromPlaceholder = PlaceholderController.getListOfPosts;
    List<Post> resultFromPlaceholder = await PlaceholderController.init(page);
    setState(() {
      page++;
      if (resultFromPlaceholder.length < 15) {
        hasMore = false;
      }
      posts = [...posts, ...resultFromPlaceholder];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('>>>>>>>>>>>>>>>>>> Current page ${page}');
    print('Tamanho da lista >>>> ${posts.length}');
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
                  backgroundImage: AssetImage(
                      'assets/peopleImages/${posts[index].userId}.jpg'),
                ),
                title: Text(
                  "${index} ${post.title}...",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "${post.body}...",
                  maxLines: 2,
                ),
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
