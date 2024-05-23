import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonDocteur extends StatelessWidget {
  const SkeletonDocteur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 334,
        height: 125,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.13),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 111,
                  height: 111,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.13),
                    color: Colors.grey[300],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 100,
                          height: 15,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 50,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 80,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
