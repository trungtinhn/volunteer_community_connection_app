import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_bloc.dart';
import 'sign_up_state.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(listener: (context, state) {
      if (state is SignUpFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign Up successful')),
        );
      }
    }, child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container();
    }));
  }
}
