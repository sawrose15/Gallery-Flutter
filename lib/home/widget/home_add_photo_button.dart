import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key('homeView_addPhotoButton'),
      onPressed: () {
        _showSelectionDialog(context);
      },
      child: const Icon(Icons.add_a_photo),
      backgroundColor: Colors.black45,
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select the photo From:'),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListTile(
                  title: const Text("Gallery"),
                  onTap: () async {
                    // var image = await _uploadPhoto(context, "gallery");
                    Navigator.of(context).pop();
                    context.read<PhotoOverviewBloc>().add(
                        const PhotoOverviewUploadPhoto(ImageSource.gallery));
                  },
                  leading: const Icon(
                    Icons.account_box,
                    color: Colors.black45,
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListTile(
                  title: const Text("Camera"),
                  onTap: () async {
                    // var image = await _uploadPhoto(context, "camera");
                    Navigator.of(context).pop();
                    context.read<PhotoOverviewBloc>().add(
                        const PhotoOverviewUploadPhoto(ImageSource.camera));
                  },
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.black45,
                  ),
                )
              ],
            )),
          );
        });
  }
}
