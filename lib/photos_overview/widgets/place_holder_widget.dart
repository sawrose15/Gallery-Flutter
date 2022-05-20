import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({
    Key? key,
    this.width,
    this.height,
    this.shimmerDirection = ShimmerDirection.ltr,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.boxDecoration,
    required this.baseColor,
    required this.highlightColor,
    required this.backColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final ShimmerDirection shimmerDirection;
  final Duration shimmerDuration;
  final Color baseColor;
  final Color highlightColor;
  final Color backColor;
  final BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    if (boxDecoration != null) {
      return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        direction: shimmerDirection,
        period: shimmerDuration,
        child: Container(
          width: width,
          height: height,
          decoration: boxDecoration,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        direction: shimmerDirection,
        period: shimmerDuration,
        child: Container(
          width: width,
          height: height,
          color: backColor,
        ),
      ),
    );
  }
}
