import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toubibplus/frontend/pages/connexion.dart';

void signOutAndNavigate(BuildContext context, Function showToast) async {
  await FirebaseAuth.instance.signOut();
  showToast(message: "Déconnexion effectuée avec succès");

  // Navigation vers l'écran de connexion
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const Connexion(),
    ),
  );
}
