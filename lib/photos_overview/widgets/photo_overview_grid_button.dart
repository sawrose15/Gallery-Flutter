import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewGridButton extends StatelessWidget {
  const PhotoOverviewGridButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
        builder: (context, state) {
      return IconButton(
          onPressed: () {
            context.read<PhotoOverviewBloc>().add(PhotoOverviewChangeGridLayout(
                gridSize: (state.gridSize == 5) ? 3 : 5));
          },
          icon: const Icon(Icons.grid_view));
    });
  }
}
