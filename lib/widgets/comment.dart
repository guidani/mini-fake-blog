import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';
import '../models/post_model.dart';

class CommentSection extends StatefulWidget {
  final int userid;
  const CommentSection({Key? key, required this.userid}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late Future<List<Comment>> comments = getComments(widget.userid);

  static Future<List<Comment>> getComments(int userid) async {
    // TODO: Seguir o exemplo do tutorial tirando a tipagem do Future...
    final url = 'https://jsonplaceholder.typicode.com/posts/$userid/comments';
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
            return const Text('Ainda não há nenhum comentário!');
          }
        },
      ),
    );
  }

  Widget buildComments(List<Comment> comments) => ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: FlutterLogo(),
            ),
            title: Text(comment.name),
            // TODO: trocar por icones de like e deslike
            trailing: const Icon(Icons.arrow_forward),
          ),
        );
      });
}

class Arguments {
  final int userid;
  Arguments(this.userid);
}
