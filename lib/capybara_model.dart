import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capybara/capybara_action.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class CapybaraModel extends StatefulWidget {
  const CapybaraModel({super.key});

  @override
  State<CapybaraModel> createState() => _CapybaraModelState();
}

class _CapybaraModelState extends State<CapybaraModel> {
  @override
  Widget build(BuildContext context) {
    final capybaraAction = Provider.of<CapybaraAction>(context);
    print('capybaraAction.action: ${capybaraAction.action}');
    return Expanded(
        child: ModelViewer(
      key: ValueKey(capybaraAction.action),
      backgroundColor: const Color.fromARGB(255, 29, 0, 37),
      src: 'www/camel/${capybaraAction.action}.glb',
      alt: '牛马打工中',
      ar: true,
      autoPlay: true,
      iosSrc: 'www/camel/${capybaraAction.action}.glb',
      disableZoom: true,
    ));
  }
}
