import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final Widget iconImage;
  final String textButton;
  final width;
  final height;

  const BuildButton({
    super.key,
    required this.iconImage,
    required this.textButton,
    this.width = double
        .infinity, // Utilisez la valeur par défaut de double.infinity pour la largeur
    this.height = 60.0, // Utilisez la valeur par défaut de 60.0 pour la hauteur
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        ),
        minimumSize:
            Size(width, height), // Définir la largeur et la hauteur ici
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconImage,
          const SizedBox(width: 10),
          Text(textButton),
        ],
      ),
    );
  }
}


class BuildButton1 extends StatelessWidget {
  final Widget iconImage;
  final String textButton;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const BuildButton1({
    Key? key,
    required this.iconImage,
    required this.textButton,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(width, height),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconImage,
          const SizedBox(width: 10),
          Text(textButton),
        ],
      ),
    );
  }
}
