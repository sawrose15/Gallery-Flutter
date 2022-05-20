import 'package:flutter/material.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_view/photo_view.dart';

class PhotoDetailView extends StatelessWidget {
  const PhotoDetailView({
    Key? key,
    required Photo photo,
  })  : _photo = photo,
        super(key: key);

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(_photo.fileName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Stack(
        children: [
          PhotoView(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
            imageProvider: NetworkImage(_photo.filePath),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              textDirection: TextDirection.ltr,
              children: [
                Text(
                  'Photo Name: ${_photo.fileName}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Uploaded By: ${_photo.uploadedBy}',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Upload Date: ${_photo.uploadedDate}',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
