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
        children: [
          Row(
            children: [
              Container(
                width: 111,
                height: 111,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 100,
                    height: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 50,
                    height: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 100,
                    height: 15,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 15,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
