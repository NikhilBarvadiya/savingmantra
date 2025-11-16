import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  void dioToast({required IconData icon, required String txt}) {
    toastification.dismissAll();
    toastification.show(
      icon: Icon(icon, color: Colors.red),
      title: Text(txt),
      progressBarTheme: const ProgressIndicatorThemeData(color: Colors.red, linearMinHeight: 2),
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  void infoToast({required IconData icon, required String txt}) {
    toastification.dismissAll();
    toastification.show(
      icon: Icon(icon, color: Colors.amber),
      title: Text(txt),
      progressBarTheme: const ProgressIndicatorThemeData(color: Colors.amber, linearMinHeight: 2),
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  void successToast({required String txt}) {
    toastification.dismissAll();
    toastification.show(
      type: ToastificationType.success,
      title: Text(txt),
      progressBarTheme: const ProgressIndicatorThemeData(color: Colors.green, linearMinHeight: 2),
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  void internalServerError(String error) {
    toastification.dismissAll();
    toastification.show(
      icon: const Icon(Icons.error, color: Colors.red),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Internal server error occurred, please try again later."),
          const SizedBox(height: 4),
          Text(
            error.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ),
      progressBarTheme: const ProgressIndicatorThemeData(color: Colors.red, linearMinHeight: 2),
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}

AppToast appToast = AppToast();