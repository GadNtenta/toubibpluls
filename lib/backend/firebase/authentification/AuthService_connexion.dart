import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toubibplus/frontend/messages/toast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      // Vérifier l'utilisateur dans Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user!.uid).get();

      if (!userDoc.exists) {
        showToast(message: "L'utilisateur n'existe pas.");
        return null;
      } else {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData['password'] != password) {
          showToast(message: "Le mot de passe saisi est incorrect.");
          return null;
        }
      }

      return user;
    } catch (e) {
      print("Error in signInWithEmailAndPassword: $e");
      //showToast(message: "Erreur lors de la connexion : $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;

        // Enregistrer les informations de l'utilisateur dans Firestore
        if (user != null) {
          DocumentReference userRef = _firestore.collection('users').doc(user.uid);
          DocumentSnapshot userDoc = await userRef.get();

          if (!userDoc.exists) {
            await userRef.set({
              'nom': googleSignInAccount.displayName?.split(' ')[0] ?? '',
              'prenom': googleSignInAccount.displayName?.split(' ').skip(1).join(' ') ?? '',
              'email': user.email,
              'date_naissance': '', // Google ne fournit pas cette info directement
              'profile': user.photoURL,
              'etat': 'connecter',
              'user': 'patient',
            });

            /*await userRef.collection('patients').doc(user.uid).set({
              'nom': googleSignInAccount.displayName?.split(' ')[0] ?? '',
              'prenom': googleSignInAccount.displayName?.split(' ').skip(1).join(' ') ?? '',
              'adresse': '',
              'numero_de_telephone': '',
              'date_naissance': '', // Google ne fournit pas cette info directement
              'sexe': '',
              'email': user.email,
              'profile': user.photoURL,
              'id': 'Pat-${user.uid}',
            });*/
          }
        }

        return user;
      } else {
        showToast(message: "Connexion Google annulée.");
        return null;
      }
    } catch (e) {
      print("Error in signInWithGoogle: $e");
      showToast(message: "Erreur lors de la connexion avec Google : $e");
      return null;
    }
  }
}
