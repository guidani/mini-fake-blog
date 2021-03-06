import 'package:fetch_users_01/widgets/comment.dart';
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User ${args.userId}"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/peopleImages/${args.userId}.jpg'),
              ),
              title: Text(args.title),
              subtitle: Text(args.body),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(child: CommentSection(userid: args.userId)),
        ],
      ),
    );
  }
}
