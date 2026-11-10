/// Model untuk menyimpan data Post.
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Mengubah data JSON menjadi objek Post.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
