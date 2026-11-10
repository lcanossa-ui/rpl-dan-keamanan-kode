import 'package:flutter/widgets.dart';

import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

/// Menyediakan seluruh dependency aplikasi.
class DependencyInjector {
  late final ApiService apiService;
  late final UserRepository userRepository;
  late final PostRepository postRepository;

  DependencyInjector() {
    apiService = ApiService.instance;

    userRepository = UserRepositoryImpl(apiService: apiService);

    postRepository = PostRepositoryImpl(apiService: apiService);
  }
}

/// Menyediakan dependency ke seluruh widget.
class DependencyProvider extends InheritedWidget {
  final DependencyInjector dependencies;

  const DependencyProvider({
    super.key,
    required this.dependencies,
    required super.child,
  });

  /// Mengambil dependency dari widget tree.
  static DependencyInjector of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DependencyProvider>();

    assert(provider != null, 'DependencyProvider tidak ditemukan.');

    return provider!.dependencies;
  }

  @override
  bool updateShouldNotify(DependencyProvider oldWidget) {
    return dependencies != oldWidget.dependencies;
  }
}
