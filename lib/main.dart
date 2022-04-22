import 'package:fetch_users_01/pages/my_home_page.dart';
import 'package:fetch_users_01/pages/template_page.dart';
import 'package:flutter/material.dart';
import 'pages/post_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TemplatePage(),
        '/post-detail': (context) => const PostDetail(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
