import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:capybara/capybara_action.dart';
import 'package:capybara/global_config.dart';

class CapybaraModel extends StatefulWidget {
  const CapybaraModel({super.key});

  @override
  State<CapybaraModel> createState() => _CapybaraModelState();
}

class _CapybaraModelState extends State<CapybaraModel> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final capybaraAction = Provider.of<CapybaraAction>(context);
    final globalConfig = Provider.of<GlobalConfig>(context);
    controller.loadRequest(Uri.parse(
        'http://${globalConfig.localAssetsServer}:${globalConfig.localAssetsServerPort}/?action=${capybaraAction.action}&description=${capybaraAction.description}&emotion=${capybaraAction.emotion}&movement=${capybaraAction.movement}'));
    return Expanded(child: WebViewWidget(controller: controller));
  }
}
