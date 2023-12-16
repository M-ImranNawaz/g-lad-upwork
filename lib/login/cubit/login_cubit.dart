import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/utils/app_utls.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginCubit() : super(LoginInitial());

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  Future<void> logIn() async {
    
    if (emailC.text.isEmpty || passwordC.text.isEmpty) {
      emit(LoginValidFailure('These fields are required'));
      return;
    }
    if (!AppUtils.isEmailValid(emailC.text)) {
      emit(LoginValidFailure('Please enter a valid email'));
      return;
    }
    emit(LoginLoading());

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  @override
  Future<void> close() {
    emailC.dispose();
    passwordC.dispose();
    return super.close();
  }
}
