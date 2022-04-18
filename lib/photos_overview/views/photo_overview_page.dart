import 'dart:ffi';

import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewPage extends StatelessWidget {

  const PhotoOverviewPage({
    Key? key,
  })  : super(key: key);

  static Page page() => const MaterialPage<Void>(child: PhotoOverviewPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) =>
        PhotoOverviewBloc(
            firebasePhotoApi: context.read<FirebasePhotoApi>()
        )..add(const PhotoOverviewSubscriptionRequested()),
      child: const PhotoOverviewView()
      );
  }
}
