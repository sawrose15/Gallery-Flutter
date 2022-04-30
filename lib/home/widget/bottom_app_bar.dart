import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/home/home.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
    required this.selectedTab,
  }) : super(key: key);

  final HomeTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.black,
      notchMargin: 2.0,
      clipBehavior: Clip.antiAlias,
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
      color: groupValue != value
          ? Colors.white
          : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
