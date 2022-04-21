import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';

class CommentSection extends StatefulWidget {
  final int postId;
  const CommentSection({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  Future<List<Comment>> comments = getComments();

  static Future<List<Comment>> getComments() async {
    // TODO: Seguir o exemplo do tutorial tirando a tipagem do Future...
    const url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Comment>(Comment.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Comment>>(
        future: comments,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final comments = snapshot.data!;
            return buildComments(comments);
          } else {
            return const Text('Sem dados');
          }
        },
      ),
    );
  }

  Widget buildComments(List<Comment> comments) => ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: FlutterLogo(),
            ),
            title: Text(comment.name),
            trailing: const Icon(Icons.arrow_forward),
          ),
        );
      });
}
