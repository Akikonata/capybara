import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:capybara/capybara_model.dart';

class CapybaraField extends StatelessWidget {
  const CapybaraField({super.key});
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Column(
      children: <Widget>[
        CapybaraModel(),
      ],
    ));
  }
}
