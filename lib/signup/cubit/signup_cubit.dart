import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/utils/app_utls.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignupCubit() : super(SignupInitial());
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  Future<void> signUp() async {
    if (emailC.text.isEmpty || passwordC.text.isEmpty || nameC.text.isEmpty) {
      emit(SignupValidFailure('These fields are required'));
      return;
    }
    if (!AppUtils.isEmailValid(emailC.text)) {
      emit(SignupValidFailure('Please enter a valid email'));
      return;
    }
    emit(SignupLoading());

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      );

      // Update the username
      await userCredential.user!.updateDisplayName(nameC.text);

      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      print('firebase exception: $e');
    }
  }

  @override
  Future<void> close() {
    emailC.dispose();
    passwordC.dispose();
    nameC.dispose();
    return super.close();
  }
}
