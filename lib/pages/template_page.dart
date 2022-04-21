import 'package:flutter/material.dart';

import 'my_home_page.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Posts'),
        centerTitle: true,
      ),
      body: const MyHomePage(),
    );
  }
}
