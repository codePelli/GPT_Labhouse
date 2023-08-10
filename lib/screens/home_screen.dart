import 'package:flutter/material.dart';
import '../model/model.dart';
import '../services/api_service.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _questionController = TextEditingController();
  String _response = '';
  bool _isLoading = false;
  bool _showEmptyMessage = false;

  @override
  void initState() {
    super.initState();
    _questionController.text = '';
  }

  //Condition for empty messages error
  Future<void> _sendMessage(String message) async {
    if (message.isEmpty) {
      setState(() {
        _showEmptyMessage = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _showEmptyMessage = false;
    });

    List<ModelChat> chatList = await ApiService.sendPromptMessage(
      message: message,
      modelId: 'gpt-3.5-turbo',
    );

    if (chatList.isNotEmpty) {
      setState(() {
        _response = chatList[0].msg;
        _isLoading = false;
      });

      Navigator.pushNamed(
        context,
        SecondScreen.id,
        arguments: _response,
      );
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png', height: 125),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _questionController,
                          decoration: const InputDecoration(
                            hintText: 'Pregúntame lo que quieras...',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => _sendMessage(_questionController.text.trim()),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF388E3C),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('images/gpt.png', height: 30, width: 30),
                              const SizedBox(width: 8),
                              const Text(
                                'ENVIAR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_showEmptyMessage)
                        const Text(
                          'Escríbeme una pregunta antes de pulsar "Enviar"',
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 80),
                      const Text(
                        'Aquí tienes algunos ejemplos, puedes pulsar sobre ellos:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //Suggesting questions to user
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _sendMessage('Top 3 equipos de LaLiga con explicación'),
                            child: const Chip(
                              label: Text('Top 3 equipos de LaLiga'),
                              backgroundColor: Color(0xFF388E3C),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _sendMessage('Top 5 películas en IMDB con explicación'),
                            child: const Chip(
                              label: Text('Top 5 películas en IMDB'),
                              backgroundColor: Color(0xFF388E3C),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _sendMessage('Top 10 restaurantes en Barcelona con explicación'),
                            child: const Chip(
                              label: Text('Top 10 restaurantes en Barcelona'),
                              backgroundColor: Color(0xFF388E3C),
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //Loading message when 'Enviar' is pressed
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Procesando tu respuesta',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              //Text at the bottom of the screen
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Powered by ChatGPT',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
