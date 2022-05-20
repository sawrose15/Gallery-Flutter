import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_gallery/shared/shared.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: selectedTab.index,
        children: const [PhotoOverviewPage(), SharedPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const UploadImageButton(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        child: Row(
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
          groupValue != value ? Colors.white : Colors.blue,
      icon: icon,
    );
  }
}
