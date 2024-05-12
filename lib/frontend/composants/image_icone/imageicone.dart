import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageIcone extends StatelessWidget {
  final String imageIcone; // Chemin de l'image de l'icône
  final double width;
  final double height;

  const ImageIcone(
      {Key? key,
      required this.imageIcone,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageIcone, // Image à afficher
      height: 50, // Hauteur de l'image
      width: 50, // Largeur de l'image
    );
  }
}

class ImageIcones extends StatelessWidget {
  const ImageIcones({
    Key? key,
    required this.ImageIcone,
    required this.width,
    required this.height,
  }) : super(key: key);

  final String ImageIcone;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImageIcone,
      width: width,
      height: height,
    );
  }
}

// icone pour la barre de tache
class ImageIcone1 extends StatelessWidget {
  const ImageIcone1(
      {Key? key,
        required this.imageIcone,
        required this.width,
        required this.height,
        required this.isSelected})
      : super(key: key);

  final String imageIcone;
  final double width;
  final double height;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color iconColor = isSelected ? const Color(0xFF66DED4) : Colors.grey;

    return SvgPicture.asset(
      imageIcone,
      width: width,
      height: height,
      color: iconColor,
    );
  }
}