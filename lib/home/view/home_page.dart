import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/app/app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<Void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text("Gallery App"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/grid.png'),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/sort.png'),
              ),
              IconButton(
                key: const Key('homePage_LogoutButton'),
                icon: Image.asset('assets/lock.png'),
                onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
              ),
            ],
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 400,
                child: Center(
                  child: Text("This is Awesome"),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
