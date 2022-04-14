import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/home/cubit/home_cubit.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_repository/photo_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoApi = FirebasePhotoApi(firestore: FirebaseFirestore.instance);
    final photoRepository = PhotoRepository(photoApi: photoApi);
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          PhotoOverviewPage(photoRepository: photoRepository),
          PhotoOverviewPage(photoRepository: photoRepository)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addPhotoButton'),
        onPressed: (){_showSelectionDialog(context);},
        child: const Icon(Icons.add_a_photo),
        backgroundColor: Colors.black45,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.home,
              icon: const Icon(Icons.home),
            ),

            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.shared,
              icon: const Icon(Icons.people_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.read<HomeCubit>().setTab(value),
        iconSize: 32,
        color:
          groupValue != value ? Colors.white : Theme.of(context).colorScheme.secondary,
        icon: icon,
    );
  }
}

Future<void> _showSelectionDialog(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Select the photo From:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(height: 1,color: Colors.blue,),
                ListTile(
                  title: const Text("Gallery"),
                  onTap: (){
                    _openGallery(context);
                  },
                  leading: Icon(Icons.account_box,color: Colors.blue,),
                ),
                Divider(height: 1,color: Colors.blue,),
                ListTile(
                  title: const Text("Camera"),
                  onTap: (){
                    _openCamera(context);
                  },
                  leading: Icon(Icons.camera,color: Colors.blue,),
                )
              ],
            )
          ),
        );
      }
  );
}

Future<File> _openGallery(BuildContext context) async {
  File? result;
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(
    source: ImageSource.gallery,
  );

  if(pickedImage!=null){
    result = File(pickedImage.path);
  }
  Navigator.pop(context);
  return result!;
}

Future<File> _openCamera(BuildContext context) async{
  File? result;
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    preferredCameraDevice: CameraDevice.rear,
  );

  if(pickedFile !=null){
    result = File(pickedFile.path);
  }
  Navigator.pop(context);
  return result!;
}

