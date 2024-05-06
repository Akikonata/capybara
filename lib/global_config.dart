import 'package:flutter/material.dart';

class GlobalConfig extends ChangeNotifier {
  String baseURL = 'http://';
  GlobalConfig({required this.baseURL});
  factory GlobalConfig.fromJson(Map<String, dynamic> json) {
    return GlobalConfig(
      baseURL: json['baseURL'] as String,
    );
  }
  void updateData({
    required String newBaseURL,
  }) {
    baseURL = newBaseURL;
    notifyListeners();
  }
}
