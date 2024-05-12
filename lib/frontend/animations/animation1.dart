import 'dart:async';

import 'package:flutter/material.dart';

class delaianimation extends StatefulWidget {
  final Widget child;
  final int delay;

  // Constructeur du widget
  const delaianimation({required this.delay, required this.child});

  @override
  State<delaianimation> createState() => _delaianimationState();
}

class _delaianimationState extends State<delaianimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffest;

  @override
  void initState() {
    super.initState();

    // Initialisation du contrôleur d'animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Définition de la courbe de décélération pour l'animation
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    // Définition de l'animation de déplacement (slide)
    _animOffest = Tween<Offset>(
      begin: const Offset(
          0.0, -0.35), // Direction de l'effet (du haut vers le bas)
      end: Offset.zero,
    ).animate(curve);

    // Démarrage de l'animation après un délai spécifié
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Application de l'animation de fondu et de déplacement à l'enfant
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffest,
        child: widget.child,
      ),
    );
  }
}
