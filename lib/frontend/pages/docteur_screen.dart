import 'package:flutter/material.dart';

import '../blocks/docteurs/representations_docteurs.dart';
import 'Home.dart';

class Docteurs extends StatelessWidget {
  const Docteurs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Barre d'application inchangée
          title: const Text(
            'Docteurs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: Colors.black,
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Accueil(),
                ),
              );
            },
          ),
        ),

        //scrollDirection: Axis.horizontal,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ToutlesDocteurs(),
          ),
        ));
  }
}
