import '../models/post.dart';

/// Abstraksi repository untuk mengelola data Post.
abstract class PostRepository {
  /// Mengambil seluruh data Post.
  Future<List<Post>> getPosts();

  /// Mengambil data Post berdasarkan ID.
  Future<Post> getPostById(int id);
}
