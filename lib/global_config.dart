import 'package:flutter/material.dart';

class GlobalConfig extends ChangeNotifier {
  String baseURL = 'http://';
  String localAssetsServer = 'http://';
  String localAssetsServerPort = '8080';
  GlobalConfig(
      {required this.baseURL,
      required this.localAssetsServer,
      required this.localAssetsServerPort});
  factory GlobalConfig.fromJson(Map<String, dynamic> json) {
    return GlobalConfig(
      baseURL: json['baseURL'] as String,
      localAssetsServer: json['localAssetsServer'] as String,
      localAssetsServerPort: json['localAssetsServerPort'] as String,
    );
  }
  void updateData({
    required String newBaseURL,
  }) {
    baseURL = newBaseURL;
    notifyListeners();
  }
}
