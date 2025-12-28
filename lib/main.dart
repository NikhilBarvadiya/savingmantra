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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.getRoutes(),
        navigatorObservers: [WebRefreshObserver()],
      ),
    );
  }
}

class WebRefreshObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _checkAndClearSession(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _checkAndClearSession(newRoute);
    }
  }

  void _checkAndClearSession(Route<dynamic> route) {
    if (ApiService().token.isEmpty && route.settings.name == AppRoutes.layout) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigator?.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      });
    }
  }
}
