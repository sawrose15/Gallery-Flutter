import 'dart:ffi';

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/home/routes/home_routes.dart';
import 'package:photo_gallery/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<Void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    // return FlowBuilder(
    //   state: context.select((HomeCubit cubit) => cubit.state.tab),
    //     onGeneratePages: onGenerateHomeViewPages
    // );
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}
