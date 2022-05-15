import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

enum ImageAction {
  share,
  rename,
  delete,
}

class ImageNetworkWidget extends StatelessWidget {
  ImageNetworkWidget({
    Key? key,
    required this.photo,
    this.onTap,
    this.onFavToggle,
  }) : super(key: key);

  final Photo photo;
  final VoidCallback? onTap;
  final VoidCallback? onFavToggle;

  final TextEditingController _renameTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('photoList ${photo.fileName}'),
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: _buildDynamicSizeImageWidget(context),
      ),
    );
  }

  Widget _buildDynamicSizeImageWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: photo.filePath,
            fit: BoxFit.cover,
            placeholder: (context, value) {
              return PlaceHolderWidget(
                width: width,
                height: height,
              );
            },
            errorWidget: (context, url, dynamic error) =>
                const Icon(Icons.error)),
        Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<ImageAction>(
                color: Colors.black,
                onSelected: (value) async {
                  switch (value) {
                    case ImageAction.share:
                      break;
                    case ImageAction.rename:
                      await _displayTextInputDialog(context, photo);
                      break;
                    case ImageAction.delete:
                      context
                          .read<PhotoOverviewBloc>()
                          .add(PhotoOverviewDeletePhoto(photo: photo));
                      break;
                  }
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem<ImageAction>(
                      value: ImageAction.share,
                      child: Text(
                        "Share....",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem<ImageAction>(
                      value: ImageAction.rename,
                      child:
                          Text("Rename", style: TextStyle(color: Colors.white)),
                    ),
                    PopupMenuItem<ImageAction>(
                      value: ImageAction.delete,
                      child:
                          Text("Remove", style: TextStyle(color: Colors.white)),
                    ),
                  ];
                })),
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
                      ))),
      ],
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Photo photo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Rename the Photo'),
            content: TextField(
              controller: _renameTextField,
              decoration: InputDecoration(hintText: photo.fileName),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('RENAME'),
                onPressed: () {
                  context.read<PhotoOverviewBloc>().add(
                      PhotoOverviewRenamePhoto(
                          photo: photo, fileName: _renameTextField.text));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
