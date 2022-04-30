import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photo_detail/photo_detail.dart';

class PhotoDetailPage extends StatelessWidget {
  const PhotoDetailPage({Key? key}) : super(key: key);

  static Route<void> route(Photo? initialPhoto) {
    return MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
              create: (context) => PhotoDetailBloc(),
              child: const PhotoDetailPage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoDetailBloc, PhotoDetailState>(
      // listenWhen: (previous, current) => previous.status,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const PhotoDetailView(),
    );
  }
}
