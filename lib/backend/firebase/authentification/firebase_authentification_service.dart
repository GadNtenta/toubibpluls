import 'package:firebase_auth/firebase_auth.dart';
import '../../../frontend/messages/toast.dart';


class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigning = false;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'Cette adresse email est deja utilisé');
      } else {
        showToast(message: "Erreur lors de la connexion : ${e.code}");
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
        showToast(message: 'Mot de passe ou email invalide.');
      } else {
        showToast(message: "Erreur lors de l'inscription : ${e.code}");
      }

    }
    return null;

  }




}
