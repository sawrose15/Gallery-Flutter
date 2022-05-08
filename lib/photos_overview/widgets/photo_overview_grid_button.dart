import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewGridButton extends StatelessWidget {
  const PhotoOverviewGridButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _grid = context.select((PhotoOverviewBloc bloc) => bloc.state.gridSize);
    return BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
        builder: (context, state) {
      _grid = state.gridSize;
      return IconButton(
          onPressed: () {
            context.read<PhotoOverviewBloc>().add(
                PhotoOverviewChangeGridLayout(gridSize: (_grid == 3) ? 5 : 3));
          },
          icon: const Icon(Icons.grid_view));
    });
  }
}
