import 'package:flutter/material.dart';
import 'home_screen.dart';

class SecondScreen extends StatelessWidget {
  static const String id = 'second_screen';

  @override
  Widget build(BuildContext context) {
    //Retrieve the response data passed from the previous screen
    final String response = ModalRoute.of(context)?.settings.arguments as String;
    //Split the response into separate lines
    List<String> lines = response.split('\n');
    //Lists to store explanation and ranking lines (if there is ranking and explanation)
    List<String> explanationLines = [];
    List<String> rankingLines = [];

    //Variable type of content
    bool isExplanation = true;
    String currentTitle = '';
    //Categorize explanation and ranking content
    for (String line in lines) {
      if (line.trim().isEmpty) {
        isExplanation = false;
        continue;
      }
      if (isExplanation) {
        explanationLines.add(line);
      } else {
        if (line.trim().startsWith('*')) {
          rankingLines.add(line);
        } else {
          explanationLines.add(line);
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  //Arrow back icon
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.id);
                    },
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    //GPT logo
                    Image.asset('images/gpt.png', height: 60, width: 60),
                    const SizedBox(height: 10),
                    const Text(
                      '¡Aquí tienes tu respuesta!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //Explanation content
              SingleChildScrollView(
                child: Column(
                  children: [
                    //Iteration to display styled containers
                    for (String line in explanationLines)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            line,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //Text at the end of every answer
              const Text(
                'Powered by ChatGPT',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
