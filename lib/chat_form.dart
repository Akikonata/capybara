import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:capybara/capybara_action.dart';
import 'package:capybara/global_config.dart';

class CapybaraResponse {
  final String status;
  final CapybaraAction data;

  CapybaraResponse({
    required this.status,
    required this.data,
  });

  factory CapybaraResponse.fromJson(Map<String, dynamic> json) {
    return CapybaraResponse(
      status: json['status'] as String,
      data: CapybaraAction.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class ChatForm extends StatefulWidget {
  const ChatForm({super.key});
  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> fetchData(
      String query, CapybaraAction updater, GlobalConfig config) async {
    try {
      var requestBody = jsonEncode(<String, String>{'message': query});
      final response = await http.post(Uri.parse('${config.baseURL}/chat'),
          headers: {'Content-Type': 'application/json'}, body: requestBody);
      if (response.statusCode == 200) {
        var data = CapybaraResponse.fromJson(
                jsonDecode(response.body) as Map<String, dynamic>)
            .data;
        updater.updateData(
            newAction: data.action,
            newEmotion: data.emotion,
            newMovement: data.movement,
            newDescription: data.description);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load capybara action');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final updater = Provider.of<CapybaraAction>(context, listen: false);
    final globalConfig = Provider.of<GlobalConfig>(context);
    final TextEditingController tController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: tController,
                  decoration: const InputDecoration(
                    hintText: '请输入你想对牛马说的话',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '输入内容不能为空';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      await fetchData(tController.text, updater, globalConfig);
                    }
                  },
                  child: const Text('发送'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
