import 'package:enam_dua_teknologi/components/white_section.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  int? looping;
  CustomShimmer({super.key, this.looping});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0XFFF5F5F5),
      highlightColor: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          itemCount: looping ?? 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: WhiteSection(
                  padding: const EdgeInsets.all(10),
                  radius: 5,
                  child: const Text('loading')),
            );
          }),
    );
  }
}
