import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio_labhouse/screens/second_screen.dart';
import 'dart:convert';
import '../model/model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _questionController = TextEditingController();
  String _response = '';

  void _sendMessage() async {
    String question = _questionController.text.trim();
    if (question.isNotEmpty) {
      //Using List instead of String for a better usage
      List<ModelChat> chatList = await ApiService.sendPromptMessage(
        message: question,
        //ChatGPT model ID
        modelId: 'gpt-3.5-turbo',
      );
      //If prompt is not empty, navigate to second screen
      if (chatList.isNotEmpty) {
        setState(() {
          _response = chatList[0].msg;
        });
        //We send the answer _response to the second screen
        Navigator.pushNamed(context, SecondScreen.id,
          arguments: _response);
      }
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatGPT App')),
      body: Column(
        children: [
          TextField(
            controller: _questionController,
            decoration: const InputDecoration(
              hintText: 'Escribe tu pregunta...',
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
