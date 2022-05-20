import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/bloc/photo_overview_bloc.dart';

enum ImageAction {
  share,
  rename,
  delete,
}

class PhotoOverviewListOptions extends StatefulWidget {
  const PhotoOverviewListOptions({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  State<PhotoOverviewListOptions> createState() =>
      _PhotoOverviewListOptionsState();
}

class _PhotoOverviewListOptionsState extends State<PhotoOverviewListOptions> {
  final TextEditingController _renameTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ImageAction>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (options) async {
        switch (options) {
          case ImageAction.share:
            break;
          case ImageAction.rename:
            await _displayTextInputDialog(context, widget.photo);
            break;
          case ImageAction.delete:
            context
                .read<PhotoOverviewBloc>()
                .add(PhotoOverviewDeletePhoto(photo: widget.photo));
            break;
        }
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: ImageAction.share,
            child: Text('Share...'),
          ),
          PopupMenuItem(
            value: ImageAction.rename,
            child: Text('Rename'),
          ),
          PopupMenuItem(
            value: ImageAction.delete,
            child: Text('Delete'),
          ),
        ];
      },
      icon: const Icon(
        Icons.more_vert,
      ),
    );
  }

  Future<void> _displayTextInputDialog(
    BuildContext context,
    Photo photo,
  ) async {
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
                        photo: photo,
                        fileName: _renameTextField.text,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
