import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/app.dart';

class PhotoOverviewLogoutButton extends StatelessWidget {
  const PhotoOverviewLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: const Key('homePage_logoutButton'),
        onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
        icon: const Icon(Icons.logout));
  }
}
