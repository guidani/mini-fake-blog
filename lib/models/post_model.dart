class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  final int? urlAvatar;

  const Post(
      {required this.body,
      required this.id,
      required this.title,
      required this.userId, this.urlAvatar});

  static Post fromJson(json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
