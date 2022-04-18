import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_api/photo_api.dart';

class PhotoOverviewGridLayout extends StatelessWidget {
  const PhotoOverviewGridLayout({
    Key? key,
    required this.crossAxisCount,
    required this.photos,
  }) : assert(crossAxisCount == 3 || crossAxisCount == 5),
        super(key: key);

  final int crossAxisCount;
  final List<Photo> photos;

  onImageTap(BuildContext context, int index) {}

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      children: [
        // ...photos.map((e) => null)
      ],
    );
  }
}
