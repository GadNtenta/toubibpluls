import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonScreens {
  static Widget buildSkeletonScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) => _buildSkeletonItem()).toList(),
      ),
    );
  }

  static Widget _buildSkeletonItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 125, // Largeur du conteneur de l'élément du docteur
        height: 187,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.13),
          border: Border.all(color: const Color(0xFFE8F3F1), width: 1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 12,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 5),
            Container(
              width: 80,
              height: 9,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 30,
                  height: 8,
                  color: Colors.grey.shade300,
                ),
                Container(
                  width: 30,
                  height: 8,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
