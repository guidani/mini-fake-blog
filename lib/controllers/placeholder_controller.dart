// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fetch_users_01/models/post_model.dart';
import 'package:fetch_users_01/repositories/jsonplaceholder_repo.dart';

class PlaceholderController {
  // static late List<Post> listOfPosts = [];

  PlaceholderController();

  // static List<Post> get getListOfPosts => listOfPosts;

  static Future<List<Post>> init(int page) async {
    List<Post> listOfPosts = [];
    List result = await JsonplaceholderRepo.getData(page);
    listOfPosts.addAll(
      result.map<Post>(
        (item) => Post(
          body: item['body'],
          id: item['id'],
          title: item['title'],
          userId: item['userId'],
        ),
      ),
    );
    return listOfPosts;
  }
}
