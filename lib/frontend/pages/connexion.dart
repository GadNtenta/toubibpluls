import 'package:flutter/material.dart';
import 'package:toubibplus/backend/firebase/authentification/AuthService_connexion.dart';
import 'package:toubibplus/frontend/composants/zone_de_saisie/inputform.dart';
import 'package:toubibplus/frontend/pages/welcome.dart';
import '../composants/boutons/boutons.dart';
import 'home.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  bool _isObscure = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connexion',
          textAlign: TextAlign.center,
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
                builder: (context) => const Bienvenue(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildEmailInput(),
              buildPasswordInput(),
              const SizedBox(height: 20),
              buildForgotPasswordText(),
              const SizedBox(height: 20),
              buildLoginButton(context),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Ou',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 25),
              buildSocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailInput() {
    return Input.buildInputForm(
      'Email',
      Icons.email,
      false,
      _emailController,
    );
  }

  Widget buildPasswordInput() {
    return Input.buildInputForm(
      'Mot de passe',
      Icons.lock,
      true,
      _passwordController,
    );
  }

  Widget buildForgotPasswordText() {
    return Container(
      alignment: Alignment.bottomRight,
      child: const Text(
        'Mot de passe oublié ?',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xFF66DED4),
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationThickness: 1,
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ()
        // fonction gérant l'authentification avec le mail et le mot de passe
        async {
          final email = _emailController.text;
          final password = _passwordController.text;
          final user = await _auth.signInWithEmailAndPassword(email, password);
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Accueil(),
              ),
            );
          }
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

  Widget buildSocialLoginButtons() {
    return Center(
      child: Column(
        children: [
          BuildButton1(
            iconImage: const Image(
              height: 25,
              width: 30,
              image: AssetImage('assets/Logos/google-logo.png'),
            ),
            textButton: 'Se connecter avec Google',
            onPressed: ()
            // fonction gérant l'authentification avec google
            async {
              try {
                await _auth.signInWithGoogle(context);
                // L'utilisateur est connecté avec succès, la navigation est gérée dans la méthode signInWithGoogle
              } catch (e) {
                // Une erreur s'est produite lors de la connexion avec Google
                print('Erreur de connexion avec Google: $e');
                // Afficher un message d'erreur si nécessaire
              }
            },
            width: 327.0,
            height: 56.0,
          ),
          const SizedBox(height: 15),
          BuildButton1(
            iconImage: const Image(
              height: 25,
              width: 30,
              image: AssetImage('assets/Logos/apple-logo.png'),
            ),
            textButton: 'Se connecter avec Apple',
            onPressed: () {
              // fonction gérant l'authentification avec Icloud
            },
            width: 327.0,
            height: 56.0,
          ),
          const SizedBox(height: 15),
          BuildButton1(
            iconImage: const Image(
              height: 25,
              width: 30,
              image: AssetImage('assets/Logos/facebook-logo.png'),
            ),
            textButton: 'Se connecter avec Facebook',
            onPressed: () {
              // fonction gérant l'authentification avec Facebook
            },
            width: 327.0,
            height: 56.0,
          ),
        ],
      ),
    );
  }

}
