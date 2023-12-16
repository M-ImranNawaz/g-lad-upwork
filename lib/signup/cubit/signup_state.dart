part of 'signup_cubit.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}


class SignupValidFailure extends SignupState {
   final String error;
  SignupValidFailure(this.error);
}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure(this.error);
}
