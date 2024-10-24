import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) {
    emit(SignUpLoading());
    try {
      // Thực hiện logic đăng ký
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(message: e.toString()));
    }
  }
}
