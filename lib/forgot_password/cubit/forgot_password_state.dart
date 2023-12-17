part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String success;
  ForgotPasswordSuccess(this.success);
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;
  ForgotPasswordFailure(this.error);
}

class ForgotPasswordValidFailure extends ForgotPasswordState {
  final String error;
  ForgotPasswordValidFailure(this.error);
}
