import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/login/cubit/login_cubit.dart';
import 'package:formz/formz.dart';
import 'package:photo_gallery/features/core/presentation/widgets/common_widgets.dart';
import 'package:photo_gallery/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showSnackBar(SnackBar(
                  content: Text(state.message ?? 'Authentication Failure')));
          }
        },
        builder: (context, state) {
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: SingleChildScrollView(
              child: ContainerX(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Assets.logo.image,
                    Image.asset(
                      'assets/logo.png',
                      height: 120,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _EmailInput(),
                    const SizedBox(
                      height: 8,
                    ),
                    _PasswordInput(),
                    const SizedBox(
                      height: 8,
                    ),
                    _LoginInput(),
                    const SizedBox(
                      height: 4,
                    ),
                    _SignUpInput(),
                  ]
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_loginButton'),
          onPressed: state.status.isValidated
              ? () => context.read<LoginCubit>().onLoginPressed()
              : null,
          child: const Text('Login'),
        );
      },
    );
  }
}

class _SignUpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_SignUpButton'),
      onPressed: ()  {
        // Navigator.of(context).push<void>(SignUpPage.route())
      },
      child: Text(
        'Create Account',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
