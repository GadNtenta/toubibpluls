// Importation des packages nécessaires
import 'package:flutter/material.dart';

import '../composants/boutons/boutons.dart';
import '../composants/zone_de_saisie/inputform.dart';
import 'Home.dart';
import 'welcome.dart';

// Classe définissant l'écran d'inscription
class InscriptionDocteurFreelance extends StatefulWidget {
  const InscriptionDocteurFreelance({Key? key}) : super(key: key);

  @override
  State<InscriptionDocteurFreelance> createState() => _InscriptionDocteurFreelanceState();
}

class _InscriptionDocteurFreelanceState extends State<InscriptionDocteurFreelance> {
  bool _isObscure = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _numerotelephoneController = TextEditingController();
  TextEditingController _specialisationController = TextEditingController();// a changer pour mettre une liste deroulante


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
          'Inscription Docteur Independant',
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
              Input.buildInputForm('Nom', Icons.person_4_rounded, false, _nomController),
              Input.buildInputForm('Prenom', Icons.person_4_rounded, false, _prenomController),
              Input.buildInputForm('Spécialisation', Icons.map, false, _specialisationController),
              Input.buildInputForm('Numéro de téléphone', Icons.call, false, _numerotelephoneController),
              Input.buildInputForm('Adresse', Icons.map, false, _adresseController),
              Input.buildInputForm('Email', Icons.email, false, _emailController),
              Input.buildInputForm(
                  'Mot de passe', Icons.lock, true, _passwordController),
              const SizedBox(height: 20),
              Container(
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
              ),
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
              const Center(
                child: Column(
                  children: [
                    BuildButton(
                      iconImage: Image(
                        height: 25,
                        width: 30,
                        image: AssetImage('assets/Logos/google-logo.png'),
                      ),
                      textButton: 'Se connecter avec Google',
                      width: 327.0,
                      height: 56.0,
                    ),
                    SizedBox(height: 15),
                    BuildButton(
                      iconImage: Image(
                        height: 25,
                        width: 30,
                        image: AssetImage('assets/Logos/apple-logo.png'),
                      ),
                      textButton: 'Se connecter avec Apple',
                      width: 327.0,
                      height: 56.0,
                    ),
                    SizedBox(height: 15),
                    BuildButton(
                      iconImage: Image(
                        height: 25,
                        width: 30,
                        image: AssetImage('assets/Logos/facebook-logo.png'),
                      ),
                      textButton: 'Se connecter avec Facebook',
                      width: 327.0,
                      height: 56.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center buildLoginButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Accueil(),
            ),
          );
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
            "Inscription",
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
}
