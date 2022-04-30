import 'package:flutter/material.dart';
import 'package:photo_gallery/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: LoginForm(),
          // create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          // child: const LoginForm(),
      ),
    );
  }
}
