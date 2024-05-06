import 'package:flutter/material.dart';

class CapybaraAction extends ChangeNotifier {
  String action = 'walk';
  String emotion = 'happy';
  String movement = '0';
  String description = '牛马打工中';
  CapybaraAction(
      {required this.action,
      required this.emotion,
      required this.movement,
      required this.description});
  factory CapybaraAction.fromJson(Map<String, dynamic> json) {
    return CapybaraAction(
      action: json['action'] as String,
      emotion: json['emotion'] as String,
      movement: json['movement'] as String,
      description: json['description'] as String,
    );
  }
  void updateData({
    required String newAction,
    required String newEmotion,
    required String newMovement,
    required String newDescription,
  }) {
    action = newAction;
    emotion = newEmotion;
    movement = newMovement;
    description = newDescription;
    notifyListeners();
  }
}
