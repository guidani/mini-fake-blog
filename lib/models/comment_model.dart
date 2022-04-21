class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment(
      {required this.body,
      required this.id,
      required this.name,
      required this.postId,
      required this.email});

  static Comment fromJson(json) => Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      body: json['body'],
      email: json['email']);
}
