import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  static const String id = 'second_screen';

  @override
  Widget build(BuildContext context) {
    final String response = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text('Respuesta')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            response,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
