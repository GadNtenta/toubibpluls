import 'package:flutter/material.dart';

import '../animations/animation1.dart';
import 'connexion.dart';
import 'inscription.dart';

class Bienvenue extends StatelessWidget {
  const Bienvenue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              vertical: 200,
              horizontal: 60,
            ),
            child: Column(
              children: <Widget>[
                // Première animation avec une image
                SizedBox(
                  height: 200,
                  child: delaianimation(
                    delay: 1500,
                    child: Image.asset(
                        'assets/Logos/Logo-toubib-1.png'), // Remplacez cette image par votre propre chemin d'image
                  ),
                ),
                // Deuxième animation avec du texte
                const delaianimation(
                  delay: 2500,
                  child: Text(
                    "C'est parti!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Troisième animation avec un autre texte
                const delaianimation(
                  delay: 3500,
                  child: Text(
                    "Connectez-vous pour profiter de nos fonctionnalités et rester en bonne santé!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Bouton de connexion avec animation
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: delaianimation(
                    delay: 4000,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF66DED4),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13),
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFF66DED4),
                        ),
                      ),
                      child: const Text(
                        "Connexion",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Navigation vers l'écran de connexion
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Connexion(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Bouton d'inscription avec animation
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: delaianimation(
                    delay: 4500,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13),
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF66DED4),
                        ),
                      ),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF66DED4),
                        ),
                      ),
                      onPressed: () {
                        // Navigation vers l'écran d'inscription
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Inscription(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
