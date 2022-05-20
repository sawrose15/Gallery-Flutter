import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return (state.status == PhotoOverviewStatus.loading)
            ? const CircularProgressIndicator()
            : FloatingActionButton(
                key: const Key('homeView_addPhotoButton'),
                onPressed: () => _showSelectionDialog(context),
                backgroundColor: Colors.black45,
                child: const Icon(Icons.add_a_photo),
              );
      },
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text(
                'Choose Image From:',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                context.read<PhotoOverviewBloc>().add(
                      const PhotoOverviewUploadPhoto(ImageSource.camera),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                context.read<PhotoOverviewBloc>().add(
                      const PhotoOverviewUploadPhoto(ImageSource.gallery),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
