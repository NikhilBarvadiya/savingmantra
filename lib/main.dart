import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/constants/app_constants.dart';
import 'package:savingmantra/core/themes/app_theme.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/presentation/router/app_routes.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService().init();

  // Clear auth on web refresh - logout on F5/page reload for web only
  if (kIsWeb) {
    // On web, always start with empty token to force login after refresh
    ApiService().token = "";
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp(title: AppConstants.appName, theme: AppTheme.lightTheme, debugShowCheckedModeBanner: false, initialRoute: AppRoutes.login, routes: AppRoutes.getRoutes()),
    );
  }
}
