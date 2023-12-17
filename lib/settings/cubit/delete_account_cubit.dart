import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  final TextEditingController passwordC = TextEditingController();
  Future<void> deleteAccount() async {
    if (passwordC.text.isEmpty) {
      emit(DeleteAccountValidFailure('This field is required'));
      return;
    }
    emit(DeleteAccountLoading());
    final res = await reAuthenticateUser(
        FirebaseAuth.instance.currentUser?.email ?? "", passwordC.text);
    if (!res) {
      emit(DeleteAccountFailure('Error occured in authentication'));
      return;
    }

    try {
      // await FirebaseAuth.instance.auth
      await FirebaseAuth.instance.currentUser?.delete();
      emit(DeleteAccountSuccess());
    } on FirebaseAuthException catch (e) {
      print('exception $e ${e.message}');
      emit(DeleteAccountFailure(e.message ?? 'Unknown error occurred'));
    }
  }

  Future<bool> reAuthenticateUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      // Handle errors if any
      print('exception $e');
      return false;
    }
  }

  @override
  Future<void> close() {
    passwordC.dispose();
    return super.close();
  }
}
