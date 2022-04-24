import 'package:fetch_users_01/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  final postRepo = PostRepository(Client());

  test('should get a list os Posts', () async {
    var response = await postRepo.getPosts();

    expect(response, isNotNull);
    expect(response.length, 20);
    expect(response[0].id, 1);
  });
}

var resultMock = 
  List.generate(20, (index) => {
    
  });
  // {
  //   "body": "",
  //   "id": 1,
  //   "title": "",
  //   "userId": 1,
  // };
