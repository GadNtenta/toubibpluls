import 'package:flutter/material.dart';
import 'package:toubibplus/frontend/messages/toast.dart';
import 'package:toubibplus/backend/firebase/authentification/inscription_service.dart';
import 'package:toubibplus/frontend/composants/zone_de_saisie/inputform.dart';
import 'package:toubibplus/frontend/pages/home.dart';
import 'package:toubibplus/frontend/pages/welcome.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool _isObscure = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final InscriptionService _inscriptionService = InscriptionService();
  bool _isSigningUp = false;

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
          'Inscription',
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
              Input.buildInputForm('Email', Icons.email, false, _emailController),
              Input.buildInputForm('Mot de passe', Icons.lock, true, _passwordController),
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
              buildSignUpButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Center buildSignUpButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _isSigningUp ? null : _signUp,
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
          child: _isSigningUp
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
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

  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text;

    try {
      await _inscriptionService.signUp(context, email, password);
    } catch (e) {
      print(e);
      if (e.toString().contains('Cet utilisateur existe déjà')) {
        showToast(message: 'Cet utilisateur existe déjà.');
        _emailController.clear();
        _passwordController.clear();
      } else if (e.toString().contains('Le mot de passe doit contenir au moins 5 caractères.')) {
        showToast(message: 'Le mot de passe doit contenir au moins 5 caractères.');
        _passwordController.clear();
      } else {
        showToast(message: 'Erreur lors de l\'inscription');
      }
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }

}
