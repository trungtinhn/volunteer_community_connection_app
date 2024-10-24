import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_sign_up/sign_up_bloc.dart';
import 'bloc_sign_up/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: const SignUpForm(),
      ),
    );
  }
}
