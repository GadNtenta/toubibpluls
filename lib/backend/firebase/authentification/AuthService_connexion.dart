import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toubibplus/frontend/messages/toast.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserID() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return user.uid;

        }

      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error in getCurrentUserID: $e");
      }
      return null;
    }
  }

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

        // Obtenir l'ID de l'utilisateur
        String userId = user!.uid;

        // Enregistrer les informations de l'utilisateur dans Firestore
        if (user != null) {
          DocumentReference userRef = _firestore.collection('users').doc(userId);
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
              'id': userId, // Enregistrez l'ID de l'utilisateur
            });

          }
        }

        return user;
      } else {
        showToast(message: "Connexion Google annulée.");
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in signInWithGoogle: $e");
      }
      showToast(message: "Erreur lors de la connexion avec Google : $e");
      return null;
    }
  }
}
