import 'package:flutter/material.dart';
import 'package:photo_gallery/configs/constants.dart';

class ContainerX extends StatelessWidget {
  const ContainerX({Key? key, this.child, this.color}) : super(key: key);

  final Widget? child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: color ?? Colors.transparent,
        constraints: const BoxConstraints(
          maxWidth: spaceMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
