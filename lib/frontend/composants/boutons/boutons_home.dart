import 'package:flutter/material.dart';

// Widget pour les boutons
class BuildButton extends StatelessWidget {
  final String textButton; // Texte du bouton

  const BuildButton({
    Key? key,
    required this.textButton,
    required Image iconImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Conteneur du bouton
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      width: double.infinity, // Largeur du bouton (largeur de l'écran)
      height: 60, // Hauteur du bouton
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Bordures arrondies du bouton
        border: Border.all(
          color: Colors.grey, // Couleur de la bordure du bouton
        ),
      ),
      child: Row(
        children: [
          Text(
            textButton, // Texte du bouton
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget pour le bouton "En savoir plus"
class BuildButton2 extends StatelessWidget {
  final String textButton; // Texte du bouton
  final Icon? iconImage; // Icône du bouton (peut être nulle)

  const BuildButton2({Key? key, required this.textButton, this.iconImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Action à effectuer lorsque le bouton est pressé
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF66DED4)), // Couleur de fond du bouton
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (iconImage != null)
            iconImage!, // Affiche l'icône si elle est spécifiée
          SizedBox(
              width: iconImage != null
                  ? 8.0
                  : 0), // Espace entre l'icône et le texte
          Text(textButton), // Texte du bouton
        ],
      ),
    );
  }
}