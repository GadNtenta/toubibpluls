import 'package:firebase_auth/firebase_auth.dart';
import '../../../frontend/messages/toast.dart';


class FirebaseAuthService {
  // Instance de FirebaseAuth pour gérer l'authentification
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Méthode pour l'inscription
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Utilisation de FirebaseAuth pour créer un nouvel utilisateur avec e-mail et mot de passe
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Retourne l'utilisateur créé
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Si l'adresse e-mail est déjà utilisée, affiche un message
        showToast(message: "L'adresse mail saisie est déjà utilisée");
      } else {
        // Sinon, affiche un message avec le code d'erreur
        showToast(message: "Une erreur est rencontrée: ${e.code}");
      }
    }
    // En cas d'erreur, retourne null
    return null;
  }

  // Méthode pour la connexion
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Utilisation de FirebaseAuth pour connecter l'utilisateur avec e-mail et mot de passe
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Retourne l'utilisateur connecté
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-not-found' || e.code == 'wrong-password') {
        // Si l'adresse e-mail n'est pas trouvée ou le mot de passe est incorrect, affiche un message
        showToast(message: "Email ou Mot de passe invalide");
      } else {
        // Sinon, affiche un message avec le code d'erreur
        showToast(message: "Une erreur est rencontrée: ${e.code}");
      }
    }
    // En cas d'erreur, retourne null
    return null;
  }


}
/*




import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';


class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }




}*/