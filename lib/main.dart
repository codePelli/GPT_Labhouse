import 'package:flutter/material.dart';
import 'package:radio_labhouse/screens/second_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/splash_screen.dart';


void main() {
  runApp(RadioLabhouse());
}

class RadioLabhouse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RadioLabhouse',
      initialRoute: SplashScreen.id, //First screen that will load when app is running
      routes: {
        //Routes to different screens
        SplashScreen.id: (context) => SplashScreen(), //Assigned id to each screen
        HomeScreen.id: (context) => HomeScreen(),
        SecondScreen.id:(context) => SecondScreen(),
      },
    );
  }
}
