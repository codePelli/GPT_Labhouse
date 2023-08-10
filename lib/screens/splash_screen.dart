import 'package:flutter/material.dart';
import 'package:radio_labhouse/Screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 4), (){ //Duration loading bar
      Navigator.pushNamed(context, HomeScreen.id); //Navigator to next screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo.png'),
            const SizedBox(height: 20),
            const LinearProgressIndicator( //Horizontal loading bar
              backgroundColor: Colors.grey,
              color: Colors.white,
            ), //Loading bar
          ],
        ),
      ),
    );
  }
}
