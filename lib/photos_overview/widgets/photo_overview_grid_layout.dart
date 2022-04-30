import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewGridLayout extends StatelessWidget {
  const PhotoOverviewGridLayout({
    Key? key,
    required this.crossAxisCount,
    required this.photos,
  })  : assert(crossAxisCount == 3 || crossAxisCount == 5),
        super(key: key);

  final int crossAxisCount;
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) => ImageTile(
              photo: photos[index],
            ));
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              imageUrl: photo.filePath,
              placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  )),
          Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton(
                  color: Colors.black,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        child: Text(
                          "Share....",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      PopupMenuItem(
                        child: const Text("Rename",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          context.read<PhotoOverviewBloc>().add(
                              PhotoOverviewRenamePhoto(
                                  photo: photo, fileName: "fileName"));
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Remove",
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          context
                              .read<PhotoOverviewBloc>()
                              .add(PhotoOverviewDeletePhoto(photo: photo));
                        },
                      ),
                    ];
                  })),
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                  onPressed: () {
                    context.read<PhotoOverviewBloc>().add(
                        PhotoOverviewFavouriteToggle(
                            photo: photo,
                            isFav: photo.isFav == true ? false : true));
                  },
                  color: Colors.white,
                  icon: photo.isFav
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.blue,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        )))
        ],
      ),
    );
  }
}
