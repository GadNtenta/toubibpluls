import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 50, height: 20, color: Colors.white),
                const CircleAvatar(radius: 20, backgroundColor: Colors.white),
                Container(width: 100, height: 20, color: Colors.white),
                Container(width: 100, height: 20, color: Colors.white),
                Container(width: 50, height: 20, color: Colors.white),
                Container(width: 100, height: 20, color: Colors.white),
                Container(width: 50, height: 20, color: Colors.white),
                Container(width: 100, height: 20, color: Colors.white),
                Container(width: 50, height: 20, color: Colors.white),
              ],
            ),
          );
        }),
      ),
    );
  }
}
