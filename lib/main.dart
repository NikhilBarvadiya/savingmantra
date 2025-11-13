import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/constants/app_constants.dart';
import 'package:savingmantra/core/themes/app_theme.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';
import 'package:savingmantra/presentation/pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  ApiService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
