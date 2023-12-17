import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/utils/app_utls.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final TextEditingController emailC = TextEditingController();
  Future<void> forgotPassword() async {
    if (emailC.text.isEmpty) {
      emit(ForgotPasswordValidFailure('These fields are required'));
      return;
    }
    if (!AppUtils.isEmailValid(emailC.text)) {
      emit(ForgotPasswordValidFailure('Please enter a valid email'));
      return;
    }
    emit(ForgotPasswordLoading());
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: emailC.text);
      emit(ForgotPasswordSuccess('Reset password Link sent successfully'));
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordFailure(e.message ?? 'An unknown error occurred'));
    }
  }
}
