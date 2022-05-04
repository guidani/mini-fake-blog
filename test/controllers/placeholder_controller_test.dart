import 'package:fetch_users_01/controllers/placeholder_controller.dart';
import 'package:fetch_users_01/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar uma lista de posts', () async {
    var data = await PlaceholderController.init(1);
    // List result = PlaceholderController().getListOfPosts;
    print(data);
  });
}
