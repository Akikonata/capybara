import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capybara/capybara_action.dart';

class CapybaraDescription extends StatefulWidget {
  const CapybaraDescription({super.key});

  @override
  State<CapybaraDescription> createState() => _CapybaraDescriptionState();
}

class _CapybaraDescriptionState extends State<CapybaraDescription> {
  @override
  Widget build(BuildContext context) {
    final capybaraAction = Provider.of<CapybaraAction>(context);
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      color: const Color.fromARGB(255, 29, 0, 37),
      child: Text(capybaraAction.description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
    );
  }
}
