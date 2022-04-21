import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostDetail extends StatefulWidget {
  // final Post post;
  const PostDetail({Key? key}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Post;
    // print(args);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User ${args.userId}"),
      ),
      body: Card(
        child: ListTile(
          title: Text(args.title),
          subtitle: Text(args.body),
        ),
      ),
    );
  }
}