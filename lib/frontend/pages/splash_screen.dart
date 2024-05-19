import 'package:flutter/material.dart';

import 'introduction.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Intro()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF66DED4),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment
                    .center,
                child: Image.asset("assets/Logos/logo-blanc 4.png"),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left:
                      16.0, // Ajustez la valeur de 'left' pour centrer horizontalement
                  top:
                      8.0, // Ajustez la valeur de 'top' pour centrer verticalement
                  right:
                      16.0, // Ajustez la valeur de 'right' pour centrer horizontalement
                  bottom:
                      8.0, // Ajustez la valeur de 'bottom' pour centrer verticalement
                ),
                child: Text(
                  'Powered by Nawtech',
                  textAlign: TextAlign.center, 
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
