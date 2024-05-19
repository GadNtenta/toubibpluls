import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'welcome.dart';

class Intro extends StatefulWidget {
  const Intro({
    super.key,
  });

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: "Medecin",
                body: 'Trouver le spécialistes dont vous avez besoins',
                image:
                    SvgPicture.asset('assets/Illustrations/illustration_medecin.svg'),
              ),
              PageViewModel(
                title: "Hopital",
                body: 'Trouvez le centre hospitalier le plus proche.',
                image: Image.asset('assets/Illustrations/illustration_hopital.png'),
              ),
              PageViewModel(
                title: "Pharmacie",
                body: 'Trouvez une pharmacie près de chez vous.',
                image: Image.asset('assets/Illustrations/illustration_pharmacie.png'),
              ),
            ],
            showSkipButton: true,
            skip: const Text("Passer",
                style: TextStyle(color: Color(0xFF66DED4))),
            next: Container(
                height: 70,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF66DED4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.arrow_right_alt, color: Colors.white)),
            done: const Text("Terminer",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Color(0xFF66DED4))),
            onDone: () {
              // On Done button pressed
              //navigator permet d'indiquer une route
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Bienvenue(),
                ),
              );
            },
            onSkip: () {
              // On Skip button pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Bienvenue(),
                ),
              );
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: const Color(0xFF66DED4),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
