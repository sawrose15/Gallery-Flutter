import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/home/cubit/home_cubit.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          PhotoOverviewPage(),
          PhotoOverviewPage()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: UploadImageButton(),
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

