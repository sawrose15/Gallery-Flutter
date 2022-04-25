import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewGridButton extends StatelessWidget {
  const PhotoOverviewGridButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<PhotoOverviewBloc>()
              .add(const PhotoOverviewChangeGridLayout(gridSize: 3));
        },
        icon: const Icon(Icons.grid_view),
    );
  }
}
