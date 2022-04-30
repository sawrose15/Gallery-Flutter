import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/shared/shared.dart';

class SharedPage extends StatelessWidget {
  const SharedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SharedBloc(), child: const SharedView());
  }
}
