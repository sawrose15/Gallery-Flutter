import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewFilterButton extends StatelessWidget {
  const PhotoOverviewFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((PhotoOverviewBloc bloc) => bloc.state.filter);
    return PopupMenuButton<PhotoViewFilter>(
      icon: const Icon(Icons.sort),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      onSelected: (filter) {
        context
            .read<PhotoOverviewBloc>()
            .add(PhotoOverviewFilterChanged(filter));
      },
      itemBuilder: (context){
        return [
          const PopupMenuItem(
            value: PhotoViewFilter.oldest_latest,
              child: Text('oldest-latest'),
          ),
          const PopupMenuItem(
            value: PhotoViewFilter.alphabetically,
            child: Text('a-z'),
          ),
          const PopupMenuItem(
            value: PhotoViewFilter.favorite,
            child: Text('Favorite'),
          ),
        ];
      },
    );
  }
}
