import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:photo_gallery/utils/app_route.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          title: const Text('Gallery App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => context.read<AuthenticationBloc>().add(
                    const AuthenticationEvent.loggedOut(),
                  ),
            ),
          ],
        );
      },
      routes: const [PhotoFullRoute(), SharedRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Shared',
                icon: Icon(Icons.people_alt_outlined),
              ),
            ]);
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
