import 'package:flutter/material.dart';

import '../../pages/Home.dart';

  Center buildLoginButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
           Accueil();
          //showToast(message: "L'utilisateur est connecté avec succès");
          //popUpBonretour();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 60,
          ),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF66DED4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            "Connexion",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }