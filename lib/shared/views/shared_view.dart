import 'package:flutter/material.dart';

class SharedView extends StatelessWidget {
  const SharedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared"),
      ),
    );
  }
}
