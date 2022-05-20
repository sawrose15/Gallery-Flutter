import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/di/di.dart';
import 'package:photo_gallery/photo_detail/photo_detail.dart';

class PhotoDetailPage extends StatelessWidget {
  const PhotoDetailPage({
    Key? key,
    required Photo photo,
  })  : _photo = photo,
        super(key: key);

  final Photo _photo;

  static Route<void> route(Photo photo) {
    return MaterialPageRoute(
      builder: (context) => PhotoDetailPage(
        photo: photo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PhotoDetailView(photo: _photo),
    );
  }
}
