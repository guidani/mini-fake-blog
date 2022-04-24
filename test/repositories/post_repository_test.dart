import 'package:fetch_users_01/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final postRepo = PostRepository(Client());

  test('should get a list os Posts', () async {
    var response = await postRepo.getPosts();

    expect(response, isNotNull);
    expect(response.length, 20);
    expect(response[0].id, 1);
  });
}