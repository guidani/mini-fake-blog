import 'package:fetch_users_01/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final postRepo = PostRepository();

  test('get all posts', () async {
    var response = await postRepo.getPosts();

    expect(response, isNotNull);
  });
}
