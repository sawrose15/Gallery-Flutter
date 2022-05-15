import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final BorderRadiusGeometry borderRadius;

  const PlaceHolderWidget({
    this.width = 100.0,
    this.height = 100.0,
    this.shimmerBaseColor = const Color(0xE0E0E0FF),
    this.shimmerHighlightColor = const Color(0xF5F5F5FF),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          shimmerBaseColor,
          shimmerBaseColor,
          shimmerHighlightColor,
          shimmerBaseColor,
          shimmerBaseColor,
        ],
        stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]);

    return SizedBox(
      width: width,
      height: height,
      child: Shimmer(
        gradient: gradient,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: borderRadius, color: shimmerBaseColor),
        ),
      ),
    );
  }
}
