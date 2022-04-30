import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoDetailView extends StatelessWidget {
  const PhotoDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(imageProvider: NetworkImage('')),
    );
  }
}
