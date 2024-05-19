import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toubibplus/frontend/messages/toast.dart';

class InscriptionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password) async {
    try {
      // Vérifier si l'utilisateur existe déjà
      bool userExists = await _checkUserExists(email);
      if (userExists) {
        // Afficher un message d'erreur si l'utilisateur existe déjà
        showToast(message: "Cet utilisateur existe déjà.");
        return;
      }

      // Vérifier si le mot de passe a au moins 5 caractères
      if (password.length < 5) {
        showToast(message: "Le mot de passe doit contenir au moins 5 caractères.");
        return;
      }

      // Créer un nouvel utilisateur avec Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Enregistrer les données dans la collection 'users' pour chaque utilisateur
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'password': password,
      });

      // Enregistrer les données dans la collection 'patients' pour chaque utilisateur
      await _firestore.collection('users').doc(userCredential.user!.uid).collection('patients').doc(userCredential.user!.uid).set({
        'email': email,
        'password': password,
      });

      // Afficher un message de succès
      showToast(message: "Inscription réussie");

    } catch (e) {
      // Gérer les erreurs d'inscription ici
      print(e);
      showToast(message: "Erreur lors de l'inscription");
    }
  }

  Future<bool> _checkUserExists(String email) async {
    QuerySnapshot users = await _firestore.collection('users').where('email', isEqualTo: email).get();
    return users.docs.isNotEmpty;
  }
}
