import 'package:flutter/material.dart';

import '../models/post.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

/// Halaman untuk menampilkan daftar Post.
class PostListScreen extends StatefulWidget {
  final PostRepository? repository;

  const PostListScreen({super.key, this.repository});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late final PostRepository _repository;

  List<Post> _posts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _repository = widget.repository ?? PostRepositoryImpl();

    _loadPosts();
  }

  /// Mengambil data Post dari repository.
  Future<void> _loadPosts() async {
    try {
      final result = await _repository.getPosts();

      if (!mounted) return;

      setState(() {
        _posts = result;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Post'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _loadPosts();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loadPosts,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${post.id}')),
                    title: Text(
                      post.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(post.body),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
