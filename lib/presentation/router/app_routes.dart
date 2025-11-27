import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/auth/login_page.dart';
import 'package:savingmantra/presentation/pages/layout/layout.dart';

/// App route names
class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String layout = '/layout';

  /// Get all routes
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      layout: (context) => const LayoutPage(),
    };
  }
}
