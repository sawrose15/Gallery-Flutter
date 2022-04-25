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
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shrinkWrap: true,
        cacheExtent: 2400,
        physics: const ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) =>
            ImageTile(
                filePath: photos[index].filePath,
                isFav: photos[index].isFav)
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.filePath,
    required this.isFav,
  }) : super(key: key);

  final String filePath;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            elevation: 10.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              // alignment: AlignmentDirectional.bottomEnd,
              children: [
                CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: filePath,
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
                            const PopupMenuItem(
                              child: Text("Rename",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const PopupMenuItem(
                              child: Text("Remove",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ];
                        })),
                Positioned(
                  top: 50,
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        icon: isFav
                            ? const Icon(Icons.favorite, color: Colors.blue,)
                            : const Icon(Icons.favorite_outline, color: Colors.white,)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
