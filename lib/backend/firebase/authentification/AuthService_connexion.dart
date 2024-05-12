import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erreur de connexion avec email et mot de passe: $e");
      return null;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        // Authentification avec Firebase
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        // Enregistrement des données dans Firestore
        await _addData(userCredential.user!);

        // Affichage de la boîte de dialogue de succès
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Succès"),
              content: Text("L'utilisateur a bien été enregistré."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Affichage de la boîte de dialogue d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("L'utilisateur n'a pas été enregistré."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  Future<void> _addData(User user) async {
    final DocumentReference userRef =
    _firestore.collection('users').doc(user.uid);

    // Vérifier si l'utilisateur existe déjà
    final DocumentSnapshot userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      // Enregistrer les données dans Firestore
      final Map<String, dynamic> userData = {
        'username': user.displayName,
        'birthday': null, // Vous devrez obtenir cette information si elle est disponible
        'name': user.displayName,
        'profilePicture': user.photoURL,
        'email': user.email,
        'password': null, // Les utilisateurs Google n'ont pas de mot de passe
      };

      await userRef.set(userData);
    }
  }
}
