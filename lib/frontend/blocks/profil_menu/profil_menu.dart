import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilMenu extends StatelessWidget {
  const ProfilMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}