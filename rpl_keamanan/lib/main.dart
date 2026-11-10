import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/app_config.dart';
import 'config/dependency_injector.dart';
import 'screens/post_list_screen.dart';
import 'repositories/post_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  if (!AppConfig.isConfigured()) {
    debugPrint('Konfigurasi .env belum lengkap.');
  }

  final dependencies = DependencyInjector();

  runApp(DependencyProvider(dependencies: dependencies, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPL dan Keamanan Kode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          final dependencies = DependencyProvider.of(context);

          return PostListScreen(repository: dependencies.postRepository);
        },
      ),
    );
  }
}
