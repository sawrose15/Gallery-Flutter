import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_gallery/photos_overview/widgets/photo_overview_list_options.dart';

class PhotoOverviewImageList extends StatelessWidget {
  const PhotoOverviewImageList({
    Key? key,
    required this.photo,
    this.boxFit = BoxFit.cover,
    this.width = 300,
    this.height = 300,
    this.onTap,
    this.onFavToggle,
  }) : super(key: key);

  final Photo photo;
  final double width;
  final double height;
  final BoxFit boxFit;
  final VoidCallback? onTap;
  final VoidCallback? onFavToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('photoList ${photo.fileName}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CachedNetworkImage(
              memCacheHeight: 300,
              memCacheWidth: 300,
              imageUrl: photo.filePath,
              fit: BoxFit.cover,
              placeholder: (context, value) {
                return PlaceHolderWidget(
                  width: width,
                  height: height,
                  highlightColor: const Color.fromRGBO(64, 64, 64, 0.5),
                  baseColor: const Color.fromRGBO(166, 166, 166, 1),
                  backColor: const Color.fromRGBO(217, 217, 217, 0.5),
                );
              },
              errorWidget: (context, url, dynamic error) =>
                  const Icon(Icons.error),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PhotoOverviewListOptions(photo: photo),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: onFavToggle,
                color: Colors.white,
                icon: photo.isFav
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
